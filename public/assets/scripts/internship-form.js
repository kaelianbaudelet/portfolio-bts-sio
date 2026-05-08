// Internship Form JavaScript - Handles logo image selection modal

document.addEventListener("DOMContentLoaded", function () {
    // === LOGO IMAGE SELECTION ===
    const selectLogoBtn = document.getElementById("selectLogoBtn");
    const removeLogoBtn = document.getElementById("removeLogoBtn");
    const logoPreview = document.getElementById("logoPreview");
    const companyLogoInput = document.getElementById("companyLogo");

    const modal = document.getElementById("mediaSelectorModal");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const modalCancelBtn = document.getElementById("modalCancelBtn");
    const modalValidateBtn = document.getElementById("modalValidateBtn");
    const modalGalleryGrid = document.getElementById("modalGalleryGrid");
    const modalTabs = document.querySelectorAll(".modal-tab");
    const modalTabContents = document.querySelectorAll(".modal-tab-content");
    const modalFileInput = document.getElementById("modalFileInput");
    const modalSelectFileBtn = document.getElementById("modalSelectFileBtn");
    const modalDropZone = document.getElementById("modalDropZone");
    const modalUploadProgress = document.getElementById("modalUploadProgress");
    const modalProgressFill = document.getElementById("modalProgressFill");
    const modalUploadStatus = document.getElementById("modalUploadStatus");
    const modalFooter = document.getElementById("modalFooter");
    const selectedCount = document.getElementById("selectedCount");

    let selectedImageFilename = null;
    let currentMode = "single"; // single for logo
    let availableMedia = [];

    // Open modal for logo selection
    if (selectLogoBtn) {
        selectLogoBtn.addEventListener("click", () => {
            openMediaModal("single");
        });
    }

    // Remove logo
    if (removeLogoBtn) {
        removeLogoBtn.addEventListener("click", () => {
            companyLogoInput.value = "";
            logoPreview.innerHTML = `
                <div class="image-placeholder">
                    <svg width="48" height="48" viewbox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <circle cx="8.5" cy="8.5" r="1.5"></circle>
                        <polyline points="21 15 16 10 5 21"></polyline>
                    </svg>
                    <p>Aucune image sélectionnée</p>
                </div>
            `;
        });
    }

    function openMediaModal(mode) {
        currentMode = mode;
        selectedImageFilename = null;
        modal.classList.add("active");
        document.body.style.overflow = "hidden";

        // Switch to gallery tab
        switchTab("gallery");

        // Load media
        loadMediaGallery();

        // Show/hide footer based on mode
        if (mode === "single") {
            modalFooter.style.display = "none";
        }
    }

    function closeMediaModal() {
        modal.classList.remove("active");
        document.body.style.overflow = "";
        selectedImageFilename = null;
        modalGalleryGrid.innerHTML = "";
    }

    // Close modal events
    closeModalBtn.addEventListener("click", closeMediaModal);
    modalCancelBtn.addEventListener("click", closeMediaModal);

    modal.addEventListener("click", (e) => {
        if (e.target === modal) {
            closeMediaModal();
        }
    });

    // Tab switching
    modalTabs.forEach((tab) => {
        tab.addEventListener("click", () => {
            const tabName = tab.dataset.tab;
            switchTab(tabName);
        });
    });

    function switchTab(tabName) {
        modalTabs.forEach((t) => t.classList.remove("active"));
        modalTabContents.forEach((c) => c.classList.remove("active"));

        const activeTab = document.querySelector(
            `.modal-tab[data-tab="${tabName}"]`
        );
        const activeContent = document.getElementById(`${tabName}Tab`);

        if (activeTab) activeTab.classList.add("active");
        if (activeContent) activeContent.classList.add("active");
    }

    // Load media gallery from API
    function loadMediaGallery() {
        modalGalleryGrid.innerHTML =
            '<div class="loading-spinner">Chargement...</div>';

        fetch("/admin/media/api/images")
            .then((response) => response.json())
            .then((data) => {
                // API returns {images: [...]} not a direct array
                const media = data.images || [];
                availableMedia = media;
                renderMediaGallery(media);
            })
            .catch((error) => {
                console.error("Error loading media:", error);
                modalGalleryGrid.innerHTML =
                    '<div class="error-text">Erreur lors du chargement des médias</div>';
            });
    }

    function renderMediaGallery(media) {
        if (media.length === 0) {
            modalGalleryGrid.innerHTML =
                '<div class="no-media-text">Aucun média disponible. Uploadez des fichiers dans l\'onglet Upload.</div>';
            return;
        }

        modalGalleryGrid.innerHTML = media
            .map((item) => {
                return `
                <div class="modal-gallery-item" data-filename="${item.name}">
                    <img src="${item.url}" alt="${item.name}">
                    <div class="file-name">${item.name}</div>
                </div>
            `;
            })
            .join("");

        // Add click handlers
        modalGalleryGrid
            .querySelectorAll(".modal-gallery-item")
            .forEach((item) => {
                item.addEventListener("click", () => {
                    if (currentMode === "single") {
                        handleSingleImageSelection(item);
                    }
                });
            });
    }

    function handleSingleImageSelection(item) {
        const filename = item.dataset.filename;

        // Update the logo preview
        companyLogoInput.value = filename;
        logoPreview.innerHTML = `
            <img src="/uploads/${filename}" alt="Aperçu">
            <button type="button" class="image-remove-btn" id="removeLogoBtn">
                <svg width="20" height="20" viewbox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
            </button>
        `;

        // Re-attach remove event
        const newRemoveBtn = document.getElementById("removeLogoBtn");
        if (newRemoveBtn) {
            newRemoveBtn.addEventListener("click", () => {
                companyLogoInput.value = "";
                logoPreview.innerHTML = `
                    <div class="image-placeholder">
                        <svg width="48" height="48" viewbox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                            <circle cx="8.5" cy="8.5" r="1.5"></circle>
                            <polyline points="21 15 16 10 5 21"></polyline>
                        </svg>
                        <p>Aucune image sélectionnée</p>
                    </div>
                `;
            });
        }

        // Close modal
        closeMediaModal();
    }

    // === FILE UPLOAD ===
    modalSelectFileBtn.addEventListener("click", () => {
        modalFileInput.click();
    });

    modalFileInput.addEventListener("change", (e) => {
        const files = Array.from(e.target.files);
        if (files.length > 0) {
            uploadFiles(files);
        }
    });

    // Drag and drop
    modalDropZone.addEventListener("dragover", (e) => {
        e.preventDefault();
        modalDropZone.classList.add("dragover");
    });

    modalDropZone.addEventListener("dragleave", () => {
        modalDropZone.classList.remove("dragover");
    });

    modalDropZone.addEventListener("drop", (e) => {
        e.preventDefault();
        modalDropZone.classList.remove("dragover");
        const files = Array.from(e.dataTransfer.files);
        if (files.length > 0) {
            uploadFiles(files);
        }
    });

    function uploadFiles(files) {
        modalDropZone.style.display = "none";
        modalUploadProgress.style.display = "block";

        let completed = 0;
        const total = files.length;

        files.forEach((file) => {
            const formData = new FormData();
            formData.append("file", file);
            formData.append("fileType", "image");

            fetch("/admin/media/upload", {
                method: "POST",
                body: formData,
            })
                .then((response) => {
                    if (!response.ok) {
                        return response.json().then((err) => {
                            throw new Error(
                                err.error || "Erreur lors de l'upload"
                            );
                        });
                    }
                    return response.json();
                })
                .then((data) => {
                    if (data.success) {
                        completed++;
                        const progress = (completed / total) * 100;
                        modalProgressFill.style.width = progress + "%";
                        modalUploadStatus.textContent = `Upload ${completed}/${total}...`;

                        if (completed === total) {
                            setTimeout(() => {
                                modalUploadProgress.style.display = "none";
                                modalDropZone.style.display = "flex";
                                modalProgressFill.style.width = "0%";
                                modalFileInput.value = "";

                                // Switch to gallery tab and reload
                                switchTab("gallery");
                                loadMediaGallery();
                            }, 500);
                        }
                    } else {
                        completed++;
                        alert(
                            "Erreur upload: " +
                                (data.error || "Erreur inconnue")
                        );

                        if (completed === total) {
                            modalUploadProgress.style.display = "none";
                            modalDropZone.style.display = "flex";
                            modalProgressFill.style.width = "0%";
                            modalFileInput.value = "";
                        }
                    }
                })
                .catch((error) => {
                    completed++;
                    console.error("Upload error:", error);
                    alert("Erreur lors de l'upload: " + error.message);

                    if (completed === total) {
                        modalUploadProgress.style.display = "none";
                        modalDropZone.style.display = "flex";
                        modalProgressFill.style.width = "0%";
                        modalFileInput.value = "";
                    }
                });
        });
    }
});
