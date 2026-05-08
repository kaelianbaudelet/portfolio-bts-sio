// Add styles for project skills
const projectSkillsStyle = document.createElement("style");
projectSkillsStyle.textContent = `
    .project-skills-list {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1.5rem;
        margin-top: 1.5rem;
    }
    .project-skill-card {
        background: var(--card-bg);
        border: 1px solid var(--border-color);
        border-radius: 12px;
        padding: 1.25rem;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .project-skill-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }
    .project-skill-name {
        font-size: 1rem;
        font-weight: 600;
        color: var(--text-color,);
    }
    .project-skill-description {
        font-size: 0.875rem;
        color: var(--text-secondary);
        line-height: 1.6;
        margin: 0;
    }
    @media (max-width: 768px) {
        .project-skills-list {
            grid-template-columns: 1fr;
        }
    }
`;
document.head.appendChild(projectSkillsStyle);

// Theme Toggle Functionality
const themeToggle = document.getElementById("themeToggle");
const html = document.documentElement;

const currentTheme = localStorage.getItem("theme") || "light";
html.setAttribute("data-theme", currentTheme);

if (themeToggle) {
    themeToggle.addEventListener("click", () => {
        const currentTheme = html.getAttribute("data-theme");
        const newTheme = currentTheme === "light" ? "dark" : "light";

        html.setAttribute("data-theme", newTheme);
        localStorage.setItem("theme", newTheme);
    });
}

// Mobile Menu Toggle Functionality
const mobileMenuToggle = document.getElementById("mobileMenuToggle");
const navMenu = document.getElementById("navMenu");

if (mobileMenuToggle && navMenu) {
    mobileMenuToggle.addEventListener("click", () => {
        mobileMenuToggle.classList.toggle("active");
        navMenu.classList.toggle("active");
    });

    // Close menu when clicking on a link
    const navLinks = navMenu.querySelectorAll(".nav-link");
    navLinks.forEach((link) => {
        link.addEventListener("click", () => {
            mobileMenuToggle.classList.remove("active");
            navMenu.classList.remove("active");
        });
    });

    // Close menu when clicking outside
    document.addEventListener("click", (e) => {
        if (
            !navMenu.contains(e.target) &&
            !mobileMenuToggle.contains(e.target)
        ) {
            mobileMenuToggle.classList.remove("active");
            navMenu.classList.remove("active");
        }
    });
}

const observerOptions = {
    root: null,
    rootMargin: "0px",
    threshold: 0.1,
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        if (entry.isIntersecting) {
            entry.target.style.animationPlayState = "running";
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

document.addEventListener("DOMContentLoaded", () => {
    const fadeUpElements = document.querySelectorAll(".fade-up");

    fadeUpElements.forEach((element) => {
        element.style.animationPlayState = "paused";
        observer.observe(element);
    });
});

document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute("href"));
        if (target) {
            target.scrollIntoView({
                behavior: "smooth",
                block: "start",
            });
        }
    });
});

document.addEventListener("DOMContentLoaded", () => {
    const projectCards = document.querySelectorAll(".project-card");
    const viewProjectBtns = document.querySelectorAll(".view-project-btn");
    const projectModal = document.getElementById("projectModal");
    const closeModalBtn = document.getElementById("closeModal");
    const modalInner = document.getElementById("projectModalInner");
    const modalOverlay = projectModal?.querySelector(".project-modal-overlay");

    // Fonction pour charger et afficher un projet depuis l'API
    async function openProjectModal(projectId) {
        if (!projectModal || !modalInner) return;

        console.log("Opening project modal for ID:", projectId);

        // Afficher le loader
        modalInner.innerHTML = `
            <div class="project-modal-loading">
                <div class="spinner"></div>
                <p>Chargement du projet...</p>
            </div>
        `;

        // Ouvrir la modal
        document.body.style.overflow = "hidden";
        projectModal.classList.add("active");

        try {
            // Charger les données du projet depuis l'API
            console.log(
                "Fetching project from API:",
                `/api/projects/${projectId}`
            );
            const response = await fetch(`/api/projects/${projectId}`);

            if (!response.ok) {
                throw new Error("Projet non trouvé");
            }

            const project = await response.json();
            console.log("Project loaded:", project);

            // Construire le HTML pour le carrousel d'images
            let carouselHtml = "";
            if (project.images && project.images.length > 0) {
                carouselHtml = `
                    <div class="project-carousel">
                        <div class="carousel-container">
                            <div class="carousel-track" id="carouselTrack">
                                ${project.images
                                    .map(
                                        (img, index) => `
                                    <div class="carousel-slide ${
                                        index === 0 ? "active" : ""
                                    }" data-index="${index}">
                                        <img src="${img.url}" alt="${
                                            project.title
                                        } - Image ${index + 1}">
                                    </div>
                                `
                                    )
                                    .join("")}
                            </div>
                            ${
                                project.images.length > 1
                                    ? `
                                <button class="carousel-btn carousel-prev" id="carouselPrev">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="15 18 9 12 15 6"></polyline>
                                    </svg>
                                </button>
                                <button class="carousel-btn carousel-next" id="carouselNext">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="9 18 15 12 9 6"></polyline>
                                    </svg>
                                </button>
                                <div class="carousel-indicators">
                                    ${project.images
                                        .map(
                                            (_, index) => `
                                        <button class="carousel-indicator ${
                                            index === 0 ? "active" : ""
                                        }" data-index="${index}"></button>
                                    `
                                        )
                                        .join("")}
                                </div>
                            `
                                    : ""
                            }
                        </div>
                    </div>
                `;
            } else if (project.image) {
                // Fallback to single image if no carousel images
                carouselHtml = `<img class="project-banner" src="/uploads/${project.image}" alt="${project.title}"/>`;
            }

            // Construire le HTML pour les technologies
            let technologiesHtml = "";
            if (project.technologies && project.technologies.length > 0) {
                technologiesHtml = `
                    <div class="project-detail-section">
                        <h2 class="project-detail-section-title">Technologies utilisées</h2>
                        <div class="project-tech-stack">
                            ${project.technologies
                                .map(
                                    (tech) => `
                                <div class="project-tech-item">
                                    <div class="project-tech-icon">
                                        ${
                                            tech.icon
                                                ? `<img src="/assets/tech-icons/${tech.icon}" alt="${tech.name}" style="width: 48px; height: 48px; object-fit: contain;">`
                                                : `<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <polyline points="16 18 22 12 16 6"></polyline>
                                                <polyline points="8 6 2 12 8 18"></polyline>
                                            </svg>`
                                        }
                                    </div>
                                    <span class="project-tech-name">${
                                        tech.name
                                    }</span>
                                </div>
                            `
                                )
                                .join("")}
                        </div>
                    </div>
                `;
            }

            // Construire le HTML pour les compétences BTS SIO
            let skillsHtml = "";
            if (project.skills && project.skills.length > 0) {
                skillsHtml = `
                    <div class="project-detail-section project-detail-skills">
                        <h2 class="project-detail-section-title">Compétences du référenciel BTS SIO mobilisées</h2>
                        <h2 class="project-detail-section-description">Sélectionnez une compétence ci-dessous pour consulter les preuves associées.</h2>
                        <div class="project-skills-list">
                            ${project.skills
                                .map(
                                    (skill) => {
                                        // Count preuves for this skill
                                        const skillPreuves = (project.preuves && project.preuves[skill.id]) || [];
                                        const preuveCount = skillPreuves.length;
                                        const hasPreuves = preuveCount > 0;
                                        return `
                                <div class="project-skill-card${hasPreuves ? ' skill-tag' : ''}" ${hasPreuves ? `data-skill-id="${skill.id}"` : ''}>
                                    <h3 class="project-skill-name">${skill.name}</h3>
                                    ${skill.description ? `<p class="project-skill-description">${skill.description}</p>` : ''}
                                </div>
                            `;
                                    }
                                )
                                .join("")}
                        </div>
                    </div>
                `;
            }

            // Construire le HTML pour les fichiers
            let filesHtml = "";
            if (project.files && project.files.length > 0) {
                filesHtml = `
                    <div class="project-detail-section">
                        <h2 class="project-detail-section-title">Fichiers du projet</h2>
                        <div class="project-files-grid">
                            ${project.files
                                .map(
                                    (file) => `
                                <div class="project-file-card">
                                    <div class="project-file-icon">${file.icon}</div>
                                    <div class="project-file-info">
                                        <p class="project-file-name" title="${file.originalName}">${file.originalName}</p>
                                        <p class="project-file-size">${file.fileSize}</p>
                                    </div>
                                    <div class="project-file-actions">
                                        ${file.url.match(/\.(pdf|jpg|jpeg|png|gif|webp)$/i) ? `
                                            <button class="btn-file-action btn-view-file" data-url="${file.url}" data-name="${file.originalName}" title="Prévisualiser">
                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                                    <circle cx="12" cy="12" r="3"></circle>
                                                </svg>
                                            </button>
                                        ` : ''}
                                        <a href="${file.url}" class="btn-file-action btn-download-file" download title="Télécharger">
                                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                                <polyline points="7 10 12 15 17 10"></polyline>
                                                <line x1="12" y1="15" x2="12" y2="3"></line>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            `
                                )
                                .join("")}
                        </div>
                    </div>
                `;
            }

            // Construire le HTML pour les liens
            let linksHtml = "";
            if (project.liveUrl || project.githubUrl) {
                linksHtml = '<div class="project-detail-actions">';
                if (project.liveUrl) {
                    linksHtml += `<a href="${project.liveUrl}" class="btn btn-primary" target="_blank" rel="noopener noreferrer">Voir le projet</a>`;
                }
                if (project.githubUrl) {
                    linksHtml += `<a href="${project.githubUrl}" class="btn btn-secondary" style="background-color: var(--bg-secondary); color: var(--text-primary);" target="_blank" rel="noopener noreferrer">GitHub</a>`;
                }
                linksHtml += "</div>";
            }

            // Remplir le contenu de la modal
            modalInner.innerHTML = `
                <div class="project-detail-hero" style="opacity: 0; transform: translateY(20px); transition: opacity 0.4s ease 0.15s, transform 0.4s ease 0.15s;">
                    <div class="project-detail-header">
                        <div>
                            <h1 class="project-detail-title">${
                                project.title
                            }</h1>
                            <p class="project-detail-subtitle">${
                                project.shortDescription
                            }</p>
                            ${
                                project.startedAt && project.endedAt
                                    ? `
                                        <div class="project-detail-meta">
                                            <div class="project-meta-item">
                                                <span class="project-meta-label">Date</span>
                                                <span class="project-meta-value">
                                                    Du
                                                    ${new Date(
                                                        project.startedAt
                                                    ).toLocaleDateString(
                                                        "fr-FR",
                                                        {
                                                            year: "numeric",
                                                            month: "long",
                                                            day: "numeric",
                                                        }
                                                    )}
                                                    au
                                                    ${new Date(
                                                        project.endedAt
                                                    ).toLocaleDateString(
                                                        "fr-FR",
                                                        {
                                                            year: "numeric",
                                                            month: "long",
                                                            day: "numeric",
                                                        }
                                                    )}
                                                </span>
                                            </div>
                                        </div>
                                    `
                                    : project.endedAt
                                    ? `
                                            <div class="project-detail-meta">
                                                <div class="project-meta-item">
                                                    <span class="project-meta-label">Date</span>
                                                    <span class="project-meta-value">
                                                        ${new Date(
                                                            project.endedAt
                                                        ).toLocaleDateString(
                                                            "fr-FR",
                                                            {
                                                                year: "numeric",
                                                                month: "long",
                                                                day: "numeric",
                                                            }
                                                        )}
                                                    </span>
                                                </div>
                                            </div>
                                        `
                                    : ""
                            }
                        </div>
                        ${linksHtml}
                    </div>
                    ${carouselHtml}
                </div>

                <div class="project-detail-content" style="opacity: 0; transform: translateY(20px); transition: opacity 0.4s ease 0.25s, transform 0.4s ease 0.25s;">
                    ${
                        project.fullDescription
                            ? `
                        <div class="project-detail-section">
                            <h2 class="project-detail-section-title">À propos du projet</h2>
                            <div class="project-detail-text prose" id="projectDescription" style="max-width: 100%;"></div>
                        </div>
                    `
                            : ""
                    }

                    ${technologiesHtml}
                    ${skillsHtml}
                    ${filesHtml}
                </div>
            `;

            // Injecter le Markdown parsé
            if (project.fullDescriptionHtml) {
                const descContainer =
                    document.getElementById("projectDescription");
                if (descContainer) {
                    descContainer.innerHTML = project.fullDescriptionHtml;
                }
            }

            // Animer le contenu après un court délai
            requestAnimationFrame(() => {
                requestAnimationFrame(() => {
                    const hero = modalInner.querySelector(
                        ".project-detail-hero"
                    );
                    const content = modalInner.querySelector(
                        ".project-detail-content"
                    );
                    if (hero) {
                        hero.style.opacity = "1";
                        hero.style.transform = "translateY(0)";
                    }
                    if (content) {
                        content.style.opacity = "1";
                        content.style.transform = "translateY(0)";
                    }
                });
            });

            // Initialiser le carrousel si présent
            if (project.images && project.images.length > 1) {
                initCarousel(project.images.length);
            }

            // Initialiser les écouteurs pour la prévisualisation des fichiers
            initFilePreviewListeners();

            // === Initialiser les preuves (clickable skill cards) ===
            initPreuvesInteraction(project);
        } catch (error) {
            console.error("Error loading project:", error);
            // Afficher une erreur
            modalInner.innerHTML = `
                <div class="project-modal-error">
                    <h3>Erreur</h3>
                    <p>${error.message}</p>
                </div>
            `;
        }
    }

    // Fonction pour fermer la modal
    function closeProjectModal() {
        if (!projectModal) return;

        projectModal.classList.add("closing");

        setTimeout(() => {
            projectModal.classList.remove("active", "closing");
            document.body.style.overflow = "";

            // Vérifier si on doit retourner à la page des compétences
            const returnToSkillId = sessionStorage.getItem("returnToSkill");

            if (returnToSkillId) {
                // Nettoyer le sessionStorage
                sessionStorage.removeItem("returnToSkill");

                // Rediriger vers la page des compétences avec le skillId pour réouvrir le modal
                window.location.href = `/skills?skillId=${returnToSkillId}`;
                return;
            }

            // Vérifier si on doit retourner à la page des stages
            const returnToInternshipId =
                sessionStorage.getItem("returnToInternship");

            if (returnToInternshipId) {
                // Nettoyer le sessionStorage
                sessionStorage.removeItem("returnToInternship");

                // Rediriger vers la page des stages avec l'internshipId pour réouvrir le modal
                window.location.href = `/internships?internshipId=${returnToInternshipId}`;
            }
        }, 300);
    }

    // Ajouter les événements de clic sur les boutons "Voir les détails"
    viewProjectBtns.forEach((btn) => {
        btn.addEventListener("click", (e) => {
            e.stopPropagation(); // Empêcher la propagation vers la carte
            const projectId = btn.getAttribute("data-project-id");
            console.log("Button clicked, project ID:", projectId);
            if (projectId) {
                openProjectModal(projectId);
            }
        });
    });

    // Ajouter les événements de clic sur les cartes (optionnel)
    projectCards.forEach((card) => {
        card.addEventListener("click", (e) => {
            // Ne pas ouvrir si on clique sur un lien direct (GitHub, Live)
            if (e.target.closest("a")) {
                return;
            }
            // Ne pas ouvrir si on clique sur le bouton "Voir les détails"
            if (e.target.closest(".view-project-btn")) {
                return;
            }

            const projectId = card.getAttribute("data-project-id");
            console.log("Card clicked, project ID:", projectId);
            if (projectId) {
                openProjectModal(projectId);
            }
        });
    });

    // Fermer la modal avec le bouton
    closeModalBtn?.addEventListener("click", closeProjectModal);

    // Fermer la modal en cliquant sur l'overlay
    modalOverlay?.addEventListener("click", closeProjectModal);

    // Fermer la modal avec la touche Escape
    document.addEventListener("keydown", (e) => {
        if (e.key === "Escape" && projectModal?.classList.contains("active")) {
            closeProjectModal();
        }
    });

    // ==== CAROUSEL FUNCTIONALITY ====
    function initCarousel(totalSlides) {
        let currentSlide = 0;
        const track = document.getElementById("carouselTrack");
        const prevBtn = document.getElementById("carouselPrev");
        const nextBtn = document.getElementById("carouselNext");
        const indicators = document.querySelectorAll(".carousel-indicator");
        const slides = document.querySelectorAll(".carousel-slide");

        if (!track || !prevBtn || !nextBtn) return;

        function goToSlide(index) {
            // Remove active class from current slide and indicator
            slides[currentSlide]?.classList.remove("active");
            indicators[currentSlide]?.classList.remove("active");

            // Update current slide
            currentSlide = index;
            if (currentSlide < 0) currentSlide = totalSlides - 1;
            if (currentSlide >= totalSlides) currentSlide = 0;

            // Add active class to new slide and indicator
            slides[currentSlide]?.classList.add("active");
            indicators[currentSlide]?.classList.add("active");

            // Move the track
            const offset = -currentSlide * 100;
            track.style.transform = `translateX(${offset}%)`;
        }

        // Button controls
        prevBtn.addEventListener("click", () => goToSlide(currentSlide - 1));
        nextBtn.addEventListener("click", () => goToSlide(currentSlide + 1));

        // Indicator controls
        indicators.forEach((indicator, index) => {
            indicator.addEventListener("click", () => goToSlide(index));
        });

        // Keyboard controls
        document.addEventListener("keydown", (e) => {
            if (!projectModal?.classList.contains("active")) return;

            if (e.key === "ArrowLeft") {
                e.preventDefault();
                goToSlide(currentSlide - 1);
            } else if (e.key === "ArrowRight") {
                e.preventDefault();
                goToSlide(currentSlide + 1);
            }
        });

        // Touch/swipe support
        let touchStartX = 0;
        let touchEndX = 0;

        track.addEventListener(
            "touchstart",
            (e) => {
                touchStartX = e.changedTouches[0].screenX;
            },
            { passive: true }
        );

        track.addEventListener(
            "touchend",
            (e) => {
                touchEndX = e.changedTouches[0].screenX;
                handleSwipe();
            },
            { passive: true }
        );

        function handleSwipe() {
            const swipeThreshold = 50;
            const diff = touchStartX - touchEndX;

            if (Math.abs(diff) > swipeThreshold) {
                if (diff > 0) {
                    // Swipe left - next slide
                    goToSlide(currentSlide + 1);
                } else {
                    // Swipe right - previous slide
                    goToSlide(currentSlide - 1);
                }
            }
        }

        // Auto-play (optional - désactivé par défaut)
        // const autoPlayInterval = 5000;
        // let autoPlayTimer = setInterval(() => goToSlide(currentSlide + 1), autoPlayInterval);

        // Pause auto-play on hover
        // track.addEventListener('mouseenter', () => clearInterval(autoPlayTimer));
        // track.addEventListener('mouseleave', () => {
        //     autoPlayTimer = setInterval(() => goToSlide(currentSlide + 1), autoPlayInterval);
        // });
    }

    // Auto-open modal if project parameter is in URL
    const urlParams = new URLSearchParams(window.location.search);
    const projectIdFromUrl = urlParams.get("project");
    const fromSkill = urlParams.get("from");

    if (projectIdFromUrl) {
        // Si on vient de la page compétences, cacher tout le contenu de la page projets
        if (fromSkill === "skill") {
            // Masquer les éléments principaux avec des classes header, main, footer
            const header = document.querySelector(".header");
            if (header) header.style.display = "none";
            const main = document.querySelector(".main");
            if (main) main.style.display = "none";
            const footer = document.querySelector(".footer");
            if (footer) footer.style.display = "none";

            // Stocker les informations de contexte avant de nettoyer l'URL
            const skillId = urlParams.get("skillId");
            if (skillId) {
                // Stocker dans sessionStorage pour garder le contexte
                sessionStorage.setItem("returnToSkill", skillId);
            }

            // Nettoyer l'URL pour la rendre discrète (garder seulement le project)
            const cleanUrl = `${window.location.pathname}?project=${projectIdFromUrl}`;
            window.history.replaceState({}, document.title, cleanUrl);
        }

        // Si on vient de la page stages, appliquer le même traitement
        const fromInternship = urlParams.get("from");
        if (fromInternship === "internship") {
            // Masquer les éléments principaux
            const header = document.querySelector(".header");
            if (header) header.style.display = "none";
            const main = document.querySelector(".main");
            if (main) main.style.display = "none";
            const footer = document.querySelector(".footer");
            if (footer) footer.style.display = "none";

            // Stocker les informations de contexte avant de nettoyer l'URL
            const internshipId = urlParams.get("internshipId");
            if (internshipId) {
                // Stocker dans sessionStorage pour garder le contexte
                sessionStorage.setItem("returnToInternship", internshipId);
            }

            // Nettoyer l'URL pour la rendre discrète (garder seulement le project)
            const cleanUrl = `${window.location.pathname}?project=${projectIdFromUrl}`;
            window.history.replaceState({}, document.title, cleanUrl);
        }

        // Wait a bit for the DOM to be fully ready
        setTimeout(() => {
            console.log("Auto-opening project modal for ID:", projectIdFromUrl);
            openProjectModal(projectIdFromUrl);
        }, 100);
    }

    // === DOCUMENT PREVIEW LOGIC ===
    const pdfModal = document.getElementById("pdfModal");
    const closePdfModalBtn = document.getElementById("closePdfModal");
    const pdfCanvas = document.getElementById("pdfCanvas");
    const pdfLoader = document.getElementById("pdfLoader");
    const pdfModalTitle = document.getElementById("pdfModalTitle");
    const imagePreviewContainer = document.getElementById("imagePreviewContainer");
    const imagePreview = document.getElementById("imagePreview");
    const pdfPrevPageBtn = document.getElementById("pdfPrevPage");
    const pdfNextPageBtn = document.getElementById("pdfNextPage");
    const pdfZoomInBtn = document.getElementById("pdfZoomIn");
    const pdfZoomOutBtn = document.getElementById("pdfZoomOut");
    const pdfPageInfo = document.getElementById("pdfPageInfo");

    let currentPdf = null;
    let currentPage = 1;
    let totalPages = 0;
    let currentScale = 1.5;
    const minScale = 0.5;
    const maxScale = 3.0;
    const scaleStep = 0.25;

    function initFilePreviewListeners() {
        const viewFileBtns = modalInner.querySelectorAll(".btn-view-file");
        viewFileBtns.forEach(btn => {
            btn.addEventListener("click", (e) => {
                e.preventDefault();
                e.stopPropagation();
                const url = btn.getAttribute("data-url");
                const name = btn.getAttribute("data-name");

                if (url.toLowerCase().endsWith(".pdf")) {
                    loadPDF(url, name);
                } else {
                    loadImagePreview(url, name);
                }
            });
        });
    }

    async function loadPDF(url, title) {
        if (!pdfModal) return;

        pdfModalTitle.textContent = title || "Aperçu du document";
        pdfModal.classList.add("active");
        pdfLoader.style.display = "flex";
        pdfCanvas.style.display = "none";
        imagePreviewContainer.style.display = "none";

        currentPage = 1;
        currentScale = 1.5;

        try {
            const loadingTask = pdfjsLib.getDocument({
                url: url,
                workerSrc: '/assets/scripts/pdf.worker.min.js'
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
            pdfLoader.innerHTML = '<p style="color: #ef4444;">Erreur lors du chargement du PDF</p>';
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

    function loadImagePreview(url, title) {
        if (!pdfModal) return;

        pdfModalTitle.textContent = title || "Aperçu de l'image";
        pdfModal.classList.add("active");
        pdfLoader.style.display = "none";
        pdfCanvas.style.display = "none";

        imagePreview.src = url;
        imagePreviewContainer.style.display = "block";

        // Cacher les contrôles PDF pour les images
        const pdfControls = pdfModal.querySelector(".pdf-controls");
        if (pdfControls) pdfControls.style.visibility = "hidden";
    }

    function updatePageInfo() {
        if (pdfPageInfo) pdfPageInfo.textContent = `${currentPage} / ${totalPages}`;
        if (pdfPrevPageBtn) pdfPrevPageBtn.disabled = currentPage <= 1;
        if (pdfNextPageBtn) pdfNextPageBtn.disabled = currentPage >= totalPages;
        if (pdfZoomOutBtn) pdfZoomOutBtn.disabled = currentScale <= minScale;
        if (pdfZoomInBtn) pdfZoomInBtn.disabled = currentScale >= maxScale;

        const pdfControls = pdfModal?.querySelector(".pdf-controls");
        if (pdfControls) pdfControls.style.visibility = "visible";
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
        currentPdf = null;
        pdfCanvas.style.display = "none";
        imagePreviewContainer.style.display = "none";
        pdfLoader.style.display = "flex";
    }

    closePdfModalBtn?.addEventListener("click", closePdfModal);
    pdfModal?.querySelector(".pdf-modal-overlay")?.addEventListener("click", closePdfModal);
    pdfPrevPageBtn?.addEventListener("click", () => changePage(-1));
    pdfNextPageBtn?.addEventListener("click", () => changePage(1));
    pdfZoomInBtn?.addEventListener("click", () => changeZoom(scaleStep));
    pdfZoomOutBtn?.addEventListener("click", () => changeZoom(-scaleStep));

    // Keyboard navigation
    document.addEventListener("keydown", (e) => {
        if (!pdfModal?.classList.contains("active")) return;

        switch (e.key) {
            case "Escape":
                closePdfModal();
                break;
            case "ArrowLeft":
                if (currentPdf) changePage(-1);
                break;
            case "ArrowRight":
                if (currentPdf) changePage(1);
                break;
        }
    });

    // === PREUVES MODAL & LIGHTBOX ===
    let preuvesModalEl = null;
    let lightboxEl = null;
    let currentLightboxPreuves = [];
    let currentLightboxIndex = 0;

    function createPreuvesModal() {
        if (preuvesModalEl) return;

        // Preuves modal
        const modalDiv = document.createElement('div');
        modalDiv.className = 'preuves-modal-overlay';
        modalDiv.id = 'preuvesModalOverlay';
        modalDiv.innerHTML = `
            <div class="preuves-modal">
                <div class="preuves-modal-header">
                    <h3 id="preuvesModalTitle">Preuves</h3>
                    <button class="preuves-modal-close" id="preuvesModalClose">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                    </button>
                </div>
                <div class="preuves-modal-body">
                    <div class="preuves-modal-grid" id="preuvesModalGrid"></div>
                </div>
            </div>
        `;
        document.body.appendChild(modalDiv);
        preuvesModalEl = modalDiv;

        // Close handlers
        document.getElementById('preuvesModalClose').addEventListener('click', closePreuvesModal);
        modalDiv.addEventListener('click', (e) => {
            if (e.target === modalDiv) closePreuvesModal();
        });

        // Lightbox
        const lightboxDiv = document.createElement('div');
        lightboxDiv.className = 'lightbox-overlay';
        lightboxDiv.id = 'lightboxOverlay';
        lightboxDiv.innerHTML = `
            <button class="lightbox-close" id="lightboxClose">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
            </button>
            <button class="lightbox-nav lightbox-prev" id="lightboxPrev">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="15 18 9 12 15 6"></polyline>
                </svg>
            </button>
            <div class="lightbox-image-container">
                <img id="lightboxImage" src="" alt="">
            </div>
            <div class="lightbox-caption">
                <h4 id="lightboxTitle"></h4>
                <p id="lightboxDesc"></p>
            </div>
            <button class="lightbox-nav lightbox-next" id="lightboxNext">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polyline points="9 18 15 12 9 6"></polyline>
                </svg>
            </button>
        `;
        document.body.appendChild(lightboxDiv);
        lightboxEl = lightboxDiv;

        // Lightbox handlers
        document.getElementById('lightboxClose').addEventListener('click', closeLightbox);
        lightboxDiv.addEventListener('click', (e) => {
            if (e.target === lightboxDiv) closeLightbox();
        });
        document.getElementById('lightboxPrev').addEventListener('click', () => navigateLightbox(-1));
        document.getElementById('lightboxNext').addEventListener('click', () => navigateLightbox(1));

        // Keyboard navigation
        document.addEventListener('keydown', (e) => {
            if (lightboxEl && lightboxEl.classList.contains('active')) {
                if (e.key === 'Escape') closeLightbox();
                else if (e.key === 'ArrowLeft') navigateLightbox(-1);
                else if (e.key === 'ArrowRight') navigateLightbox(1);
            } else if (preuvesModalEl && preuvesModalEl.classList.contains('active')) {
                if (e.key === 'Escape') closePreuvesModal();
            }
        });
    }

    function initPreuvesInteraction(project) {
        if (!project.preuves) return;

        const hasAnyPreuves = Object.keys(project.preuves).some(
            (key) => project.preuves[key].length > 0
        );
        if (!hasAnyPreuves) return;

        createPreuvesModal();

        const skillCards = modalInner.querySelectorAll('.project-skill-card[data-skill-id]');
        skillCards.forEach((card) => {
            card.addEventListener('click', () => {
                const skillId = card.dataset.skillId;
                const preuves = project.preuves[skillId] || [];
                const skillNameEl = card.querySelector('.project-skill-name');
                let skillName = skillNameEl ? skillNameEl.childNodes[0].textContent.trim() : 'Compétence';

                const skill = project.skills.find(s => s.id == skillId);
                const skillCode = skill?.code || '';

                openPreuvesModal(preuves, skillName, skillCode);
            });
        });
    }

    function openPreuvesModal(preuves, skillName, skillCode) {
        const title = document.getElementById('preuvesModalTitle');
        const grid = document.getElementById('preuvesModalGrid');

        title.innerHTML = `Preuves — ${skillName}`;

        if (preuves.length === 0) {
            grid.innerHTML = `
                <div class="preuves-empty">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <circle cx="8.5" cy="8.5" r="1.5"></circle>
                        <polyline points="21 15 16 10 5 21"></polyline>
                    </svg>
                    <p>Aucune preuve disponible pour cette compétence</p>
                </div>
            `;
        } else {
            grid.innerHTML = preuves.map((p, idx) => `
                <div class="preuve-card" data-preuve-index="${idx}">
                    <div class="preuve-card-thumb">
                        <img src="${p.url}" alt="${p.title}" loading="lazy">
                        <div class="preuve-card-zoom">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                <line x1="11" y1="8" x2="11" y2="14"></line>
                                <line x1="8" y1="11" x2="14" y2="11"></line>
                            </svg>
                        </div>
                    </div>
                    <div class="preuve-card-body">
                        <h4>${p.title}</h4>
                        ${p.description ? `<p>${p.description}</p>` : ''}
                    </div>
                </div>
            `).join('');

            currentLightboxPreuves = preuves;
            grid.querySelectorAll('.preuve-card').forEach((card) => {
                card.addEventListener('click', () => {
                    const index = parseInt(card.dataset.preuveIndex);
                    openLightbox(index);
                });
            });
        }

        preuvesModalEl.classList.add('active');
    }

    function closePreuvesModal() {
        if (preuvesModalEl) {
            preuvesModalEl.classList.remove('active');
        }
    }

    function openLightbox(index) {
        currentLightboxIndex = index;
        updateLightboxContent();
        lightboxEl.classList.add('active');
    }

    function closeLightbox() {
        if (lightboxEl) {
            lightboxEl.classList.remove('active');
        }
    }

    function navigateLightbox(direction) {
        const total = currentLightboxPreuves.length;
        currentLightboxIndex = (currentLightboxIndex + direction + total) % total;
        updateLightboxContent();
    }

    function updateLightboxContent() {
        const p = currentLightboxPreuves[currentLightboxIndex];
        if (!p) return;

        document.getElementById('lightboxImage').src = p.url;
        document.getElementById('lightboxImage').alt = p.title;
        document.getElementById('lightboxTitle').textContent = p.title;
        document.getElementById('lightboxDesc').textContent = p.description || '';

        const prevBtn = document.getElementById('lightboxPrev');
        const nextBtn = document.getElementById('lightboxNext');
        prevBtn.style.display = currentLightboxPreuves.length > 1 ? 'flex' : 'none';
        nextBtn.style.display = currentLightboxPreuves.length > 1 ? 'flex' : 'none';
    }
});
