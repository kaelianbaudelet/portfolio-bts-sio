// ========================================
// PDF.js Configuration
// ========================================
if (typeof pdfjsLib !== "undefined") {
    // Force local worker version with absolute URL
    pdfjsLib.GlobalWorkerOptions.workerSrc = window.location.origin + "/assets/scripts/pdf.worker.min.js";
}

document.addEventListener("DOMContentLoaded", function () {
    // ========================================
    // DOM Elements
    // ========================================
    const certificationsGrid = document.getElementById("certificationsGrid");
    const typeFilter = document.getElementById("typeFilter");
    const issuerFilter = document.getElementById("issuerFilter");
    const yearFilter = document.getElementById("yearFilter");
    const resetFiltersBtn = document.getElementById("resetFilters");
    const resultsCount = document.getElementById("resultsCount");
    const noResults = document.getElementById("noResults");

    // PDF Modal Elements
    const pdfModal = document.getElementById("pdfModal");
    const closePdfModalBtn = document.getElementById("closePdfModal");
    const pdfModalOverlay = pdfModal.querySelector(".pdf-modal-overlay");
    const pdfCanvas = document.getElementById("pdfCanvas");
    const pdfLoader = document.getElementById("pdfLoader");
    const pdfModalTitle = document.getElementById("pdfModalTitle");
    const pdfPrevPageBtn = document.getElementById("pdfPrevPage");
    const pdfNextPageBtn = document.getElementById("pdfNextPage");
    const pdfZoomInBtn = document.getElementById("pdfZoomIn");
    const pdfZoomOutBtn = document.getElementById("pdfZoomOut");
    const pdfPageInfo = document.getElementById("pdfPageInfo");

    // PDF State
    let currentPdf = null;
    let currentPage = 1;
    let totalPages = 0;
    let currentScale = 1.5;
    const minScale = 0.5;
    const maxScale = 3.0;
    const scaleStep = 0.25;

    // ========================================
    // Initialize Filters
    // ========================================
    function initializeFilters() {
        const cards = document.querySelectorAll(".diploma-card");
        const issuers = new Set();
        const years = new Set();

        cards.forEach((card) => {
            const issuer = card.getAttribute("data-issuer");
            const year = card.getAttribute("data-year");

            if (issuer) issuers.add(issuer);
            if (year) years.add(year);
        });

        // Populate issuer filter
        const issuerArray = Array.from(issuers).sort();
        issuerArray.forEach((issuer) => {
            const option = document.createElement("option");
            option.value = issuer;
            option.textContent = formatIssuerName(issuer);
            issuerFilter.appendChild(option);
        });

        // Populate year filter (most recent first)
        const yearArray = Array.from(years).sort((a, b) => b - a);
        yearArray.forEach((year) => {
            const option = document.createElement("option");
            option.value = year;
            option.textContent = year;
            yearFilter.appendChild(option);
        });

        updateResultsCount();
    }

    function formatIssuerName(issuer) {
        const names = {
            linkedin: "LinkedIn Learning",
            google: "Google",
            microsoft: "Microsoft",
            aws: "Amazon Web Services",
            udemy: "Udemy",
            coursera: "Coursera",
            freecodecamp: "freeCodeCamp",
        };
        return (
            names[issuer] || issuer.charAt(0).toUpperCase() + issuer.slice(1)
        );
    }

    // ========================================
    // Filtering Logic
    // ========================================
    function filterCertifications() {
        const typeValue = typeFilter.value;
        const issuerValue = issuerFilter.value;
        const yearValue = yearFilter.value;

        const cards = document.querySelectorAll(".diploma-card");
        let visibleCount = 0;

        cards.forEach((card) => {
            const cardType = card.getAttribute("data-type");
            const cardIssuer = card.getAttribute("data-issuer");
            const cardYear = card.getAttribute("data-year");

            const typeMatch = typeValue === "all" || cardType === typeValue;
            const issuerMatch =
                issuerValue === "all" || cardIssuer === issuerValue;
            const yearMatch = yearValue === "all" || cardYear === yearValue;

            if (typeMatch && issuerMatch && yearMatch) {
                card.style.display = "";
                setTimeout(() => card.classList.add("visible"), 10);
                visibleCount++;
            } else {
                card.classList.remove("visible");
                setTimeout(() => (card.style.display = "none"), 300);
            }
        });

        // Show/hide reset button
        const isDefault = typeValue === "all" && issuerValue === "all" && yearValue === "all";
        resetFiltersBtn.style.display = isDefault ? "none" : "flex";

        // Show/hide no results message
        if (visibleCount === 0) {
            noResults.style.display = "block";
            certificationsGrid.style.display = "none";
        } else {
            noResults.style.display = "none";
            certificationsGrid.style.display = "grid";
        }

        updateResultsCount();
    }

    function updateResultsCount() {
        const visibleCards = document.querySelectorAll(
            '.diploma-card:not([style*="display: none"])'
        );
        resultsCount.textContent = visibleCards.length;
    }

    function resetFilters() {
        typeFilter.value = "all";
        issuerFilter.value = "all";
        yearFilter.value = "all";
        filterCertifications();
    }

    // ========================================
    // PDF Viewer Functions
    // ========================================
    async function loadPDF(url, title) {
        if (typeof pdfjsLib === "undefined") {
            alert("PDF.js n'est pas chargé. Impossible d'afficher le PDF.");
            return;
        }

        pdfModalTitle.textContent = title || "Aperçu de la certification";
        pdfModal.classList.add("active");
        pdfLoader.style.display = "flex";
        pdfCanvas.style.display = "none";
        document.body.style.overflow = "hidden";

        currentPage = 1;
        currentScale = 1.5;

        try {
            const loadingTask = pdfjsLib.getDocument({
                url: url,
                workerSrc: pdfjsLib.GlobalWorkerOptions.workerSrc
            });
            currentPdf = await loadingTask.promise;
            totalPages = currentPdf.numPages;

            // Auto-zoom logic
            const firstPage = await currentPdf.getPage(1);
            const modalBody = pdfModal.querySelector('.pdf-modal-body');
            const availableWidth = modalBody.clientWidth - 40; // 20px padding each side
            const availableHeight = window.innerHeight * 0.8; // 80% of screen height
            const viewport = firstPage.getViewport({ scale: 1.0 });
            
            const isPortrait = viewport.height > viewport.width;
            
            if (isPortrait) {
                // For A4/Portrait: Fit to height mostly, or a conservative width fit
                const fitHeightScale = availableHeight / viewport.height;
                const fitWidthScale = availableWidth / viewport.width;
                // Use whichever is smaller to ensure the page is mostly visible, cap at 1.1
                currentScale = Math.min(fitHeightScale, fitWidthScale, 1.1);
            } else {
                // For Slides/Landscape: Fit to width is fine, cap at 1.4
                currentScale = Math.min(availableWidth / viewport.width, 1.4);
            }
            
            // Ensure we don't go below minScale
            currentScale = Math.max(currentScale, minScale);

            updatePageInfo();
            renderPage(currentPage);

            pdfLoader.style.display = "none";
        } catch (error) {
            console.error("Error loading PDF:", error);
            pdfLoader.innerHTML =
                '<p style="color: #8a2b2b;">Erreur lors du chargement du PDF</p>';
        }
    }

    async function renderPage(pageNumber) {
        if (!currentPdf) return;

        try {
            const page = await currentPdf.getPage(pageNumber);
            const viewport = page.getViewport({ scale: currentScale });

            const context = pdfCanvas.getContext("2d");
            pdfCanvas.height = viewport.height;
            pdfCanvas.width = viewport.width;
            pdfCanvas.style.display = "block";

            const renderContext = {
                canvasContext: context,
                viewport: viewport,
            };

            await page.render(renderContext).promise;
            updatePageInfo();
        } catch (error) {
            console.error("Error rendering page:", error);
        }
    }

    function updatePageInfo() {
        pdfPageInfo.textContent = `${currentPage} / ${totalPages}`;
        pdfPrevPageBtn.disabled = currentPage <= 1;
        pdfNextPageBtn.disabled = currentPage >= totalPages;
        pdfZoomOutBtn.disabled = currentScale <= minScale;
        pdfZoomInBtn.disabled = currentScale >= maxScale;
    }

    function changePage(delta) {
        const newPage = currentPage + delta;
        if (newPage >= 1 && newPage <= totalPages) {
            currentPage = newPage;
            renderPage(currentPage);
        }
    }

    function changeZoom(delta) {
        const newScale = currentScale + delta;
        if (newScale >= minScale && newScale <= maxScale) {
            currentScale = newScale;
            renderPage(currentPage);
        }
    }

    function closePdfModal() {
        pdfModal.classList.remove("active");
        document.body.style.overflow = "";
        currentPdf = null;
        pdfCanvas.style.display = "none";
        pdfLoader.style.display = "flex";
    }

    // ========================================
    // Event Listeners - Filters
    // ========================================
    typeFilter.addEventListener("change", filterCertifications);
    issuerFilter.addEventListener("change", filterCertifications);
    yearFilter.addEventListener("change", filterCertifications);
    resetFiltersBtn.addEventListener("click", resetFilters);

    // ========================================
    // Event Listeners - PDF Modal
    // ========================================
    closePdfModalBtn.addEventListener("click", closePdfModal);
    pdfModalOverlay.addEventListener("click", closePdfModal);

    pdfPrevPageBtn.addEventListener("click", () => changePage(-1));
    pdfNextPageBtn.addEventListener("click", () => changePage(1));
    pdfZoomInBtn.addEventListener("click", () => changeZoom(scaleStep));
    pdfZoomOutBtn.addEventListener("click", () => changeZoom(-scaleStep));

    // Keyboard navigation
    document.addEventListener("keydown", function (e) {
        if (!pdfModal.classList.contains("active")) return;

        switch (e.key) {
            case "Escape":
                closePdfModal();
                break;
            case "ArrowLeft":
                changePage(-1);
                break;
            case "ArrowRight":
                changePage(1);
                break;
            case "+":
            case "=":
                changeZoom(scaleStep);
                break;
            case "-":
                changeZoom(-scaleStep);
                break;
        }
    });

    // Prevent closing when clicking modal content
    document
        .querySelector(".pdf-modal-content")
        .addEventListener("click", function (e) {
            e.stopPropagation();
        });

    // ========================================
    // Event Listeners - View Buttons
    // ========================================
    function attachViewButtonListeners() {
        const viewButtons = document.querySelectorAll(".btn-view");

        viewButtons.forEach((button) => {
            button.addEventListener("click", function (e) {
                e.preventDefault();
                e.stopPropagation();

                const pdfUrl = this.getAttribute("data-pdf");
                const card = this.closest(".diploma-card");
                const title =
                    card.querySelector(".diploma-title")?.textContent ||
                    "Certification";

                if (
                    pdfUrl &&
                    pdfUrl !== "/path/to/cert1.pdf" &&
                    pdfUrl !== "/path/to/cert2.pdf"
                ) {
                    loadPDF(pdfUrl, title);
                } else {
                    alert(
                        "Le PDF pour cette certification n'est pas encore disponible."
                    );
                }
            });
        });

        // Optional: Click on card to open PDF
        const cards = document.querySelectorAll(".diploma-card");
        cards.forEach((card) => {
            card.addEventListener("click", function (e) {
                // Don't trigger if clicking on a button or link
                if (e.target.closest(".btn-diploma")) return;

                const viewBtn = this.querySelector(".btn-view");
                if (viewBtn) {
                    viewBtn.click();
                }
            });
        });
    }

    // ========================================
    // Intersection Observer for Animations
    // ========================================
    const observerOptions = {
        threshold: 0.1,
        rootMargin: "0px 0px -100px 0px",
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add("visible");
            }
        });
    }, observerOptions);

    document.querySelectorAll(".diploma-card").forEach((card) => {
        observer.observe(card);
    });

    // ========================================
    // Initialize
    // ========================================
    initializeFilters();
    attachViewButtonListeners();

    // Trigger initial filter to show all cards
    filterCertifications();
});
