// Project Form JavaScript - Handles image/file selection modals, technology selection, skill selection, and markdown editor

// Add styles for skill code badge
const style = document.createElement("style");
style.textContent = `
	.skill-code-badge {
		background: var(--accent-color);
		color: white;
		padding: 0.125rem 0.5rem;
		border-radius: 4px;
		font-size: 0.75rem;
		font-weight: 600;
		display: inline-block;
	}
	.multi-select-item .skill-code-badge {
		background: #ffffff;
        border: 1px solid var(--border-color);
		color: var(--accent-color);
	}
	.multi-select-item.selected .skill-code-badge {
		background: var(--accent-color);
		color: white;
	}
	.selected-tag .skill-code-badge {
		margin-right: 0.25rem;
	}
`;
document.head.appendChild(style);

document.addEventListener("DOMContentLoaded", function () {
    // === TECHNOLOGY SELECTION ===
    const techSearch = document.getElementById("techSearch");
    const techList = document.getElementById("techList");
    const techDropdown = document.getElementById("techDropdown");
    const selectedTags = document.getElementById("selectedTags");
    const techSelectInput = document.getElementById("techSelectInput");

    let allTechnologies = [];
    let selectedTechnologies = [];

    // Load technologies from API
    fetch("/admin/technologies/api/list")
        .then((response) => response.json())
        .then((technologies) => {
            allTechnologies = technologies;
            renderTechnologyList();
            loadSelectedTechnologies();
        })
        .catch((error) => {
            console.error("Error loading technologies:", error);
            techList.innerHTML =
                '<div class="error-text">Erreur lors du chargement des technologies</div>';
        });

    function loadSelectedTechnologies() {
        // Get selected technologies from hidden inputs (if editing)
        const form = document.querySelector(".admin-form");
        const hiddenInputs = form.querySelectorAll(
            'input[name="technologies[]"]'
        );

        hiddenInputs.forEach((input) => {
            const techId = parseInt(input.value);
            const tech = allTechnologies.find((t) => t.id === techId);
            if (tech && !selectedTechnologies.find((t) => t.id === techId)) {
                selectedTechnologies.push(tech);
            }
        });

        renderSelectedTags();
    }

    function renderTechnologyList(filter = "") {
        const filtered = allTechnologies.filter((tech) =>
            tech.name.toLowerCase().includes(filter.toLowerCase())
        );

        if (filtered.length === 0) {
            techList.innerHTML =
                '<div class="no-results">Aucune technologie trouvée</div>';
            return;
        }

        techList.innerHTML = filtered
            .map((tech) => {
                const isSelected = selectedTechnologies.some(
                    (t) => t.id === tech.id
                );
                return `
				<div class="multi-select-item ${isSelected ? "selected" : ""}" data-tech-id="${
                    tech.id
                }">
					${tech.icon ? `<span class="tech-icon">${tech.icon}</span>` : ""}
					<span class="tech-name">${tech.name}</span>
					${
                        isSelected
                            ? '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>'
                            : ""
                    }
				</div>
			`;
            })
            .join("");

        // Add click handlers
        techList.querySelectorAll(".multi-select-item").forEach((item) => {
            item.addEventListener("click", () => {
                const techId = parseInt(item.dataset.techId);
                const tech = allTechnologies.find((t) => t.id === techId);
                toggleTechnology(tech);
            });
        });
    }

    function toggleTechnology(tech) {
        const index = selectedTechnologies.findIndex((t) => t.id === tech.id);
        if (index > -1) {
            selectedTechnologies.splice(index, 1);
        } else {
            selectedTechnologies.push(tech);
        }
        renderSelectedTags();
        renderTechnologyList(techSearch.value);
    }

    function renderSelectedTags() {
        if (selectedTechnologies.length === 0) {
            selectedTags.innerHTML = "";
            return;
        }

        selectedTags.innerHTML = selectedTechnologies
            .map(
                (tech) => `
			<div class="selected-tag">
				${tech.icon ? `<span class="tech-icon">${tech.icon}</span>` : ""}
				<span>${tech.name}</span>
				<button type="button" class="tag-remove" data-tech-id="${tech.id}">
					<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<line x1="18" y1="6" x2="6" y2="18"></line>
						<line x1="6" y1="6" x2="18" y2="18"></line>
					</svg>
				</button>
				<input type="hidden" name="technologies[]" value="${tech.id}">
			</div>
		`
            )
            .join("");

        // Add remove handlers
        selectedTags.querySelectorAll(".tag-remove").forEach((btn) => {
            btn.addEventListener("click", (e) => {
                e.stopPropagation();
                const techId = parseInt(btn.dataset.techId);
                const tech = allTechnologies.find((t) => t.id === techId);
                toggleTechnology(tech);
            });
        });
    }

    // Show/hide dropdown
    techSelectInput.addEventListener("click", () => {
        techDropdown.style.display =
            techDropdown.style.display === "none" ? "block" : "none";
    });

    techSearch.addEventListener("input", (e) => {
        renderTechnologyList(e.target.value);
    });

    // Close dropdown when clicking outside
    document.addEventListener("click", (e) => {
        if (
            !techSelectInput.contains(e.target) &&
            !techDropdown.contains(e.target)
        ) {
            techDropdown.style.display = "none";
        }
    });

    // === SKILL SELECTION ===
    const skillSearch = document.getElementById("skillSearch");
    const skillList = document.getElementById("skillList");
    const skillDropdown = document.getElementById("skillDropdown");
    const selectedSkillTags = document.getElementById("selectedSkillTags");
    const skillSelectInput = document.getElementById("skillSelectInput");

    let allSkills = [];
    let selectedSkills = [];

    // Load skills from API
    fetch("/admin/skills/api/list")
        .then((response) => response.json())
        .then((skills) => {
            allSkills = skills;
            renderSkillList();
            loadSelectedSkills();
        })
        .catch((error) => {
            console.error("Error loading skills:", error);
            skillList.innerHTML =
                '<div class="error-text">Erreur lors du chargement des compétences</div>';
        });

    function loadSelectedSkills() {
        // Get selected skills from hidden inputs (if editing)
        const form = document.querySelector(".admin-form");
        const hiddenInputs = form.querySelectorAll('input[name="skills[]"]');

        hiddenInputs.forEach((input) => {
            const skillId = parseInt(input.value);
            const skill = allSkills.find((s) => s.id === skillId);
            if (skill && !selectedSkills.find((s) => s.id === skillId)) {
                selectedSkills.push(skill);
            }
        });

        renderSelectedSkillTags();
    }

    function renderSkillList(filter = "") {
        const filtered = allSkills.filter(
            (skill) =>
                skill.name.toLowerCase().includes(filter.toLowerCase()) ||
                skill.code.toLowerCase().includes(filter.toLowerCase())
        );

        if (filtered.length === 0) {
            skillList.innerHTML =
                '<div class="no-results">Aucune compétence trouvée</div>';
            return;
        }

        skillList.innerHTML = filtered
            .map((skill) => {
                const isSelected = selectedSkills.some(
                    (s) => s.id === skill.id
                );
                return `
				<div class="multi-select-item ${isSelected ? "selected" : ""}" data-skill-id="${
                    skill.id
                }">
					<div style="display: flex; align-items: center; gap: 0.5rem; flex: 1;">
						<span class="skill-code-badge">${skill.code}</span>
					</div>
					${
                        isSelected
                            ? '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>'
                            : ""
                    }
				</div>
			`;
            })
            .join("");

        // Add click handlers
        skillList.querySelectorAll(".multi-select-item").forEach((item) => {
            item.addEventListener("click", () => {
                const skillId = parseInt(item.dataset.skillId);
                const skill = allSkills.find((s) => s.id === skillId);
                toggleSkill(skill);
            });
        });
    }

    function toggleSkill(skill) {
        const index = selectedSkills.findIndex((s) => s.id === skill.id);
        if (index > -1) {
            selectedSkills.splice(index, 1);
        } else {
            selectedSkills.push(skill);
        }
        renderSelectedSkillTags();
        renderSkillList(skillSearch.value);
    }

    function renderSelectedSkillTags() {
        if (selectedSkills.length === 0) {
            selectedSkillTags.innerHTML = "";
            return;
        }

        selectedSkillTags.innerHTML = selectedSkills
            .map(
                (skill) => `
			<div class="selected-tag">
				<span class="skill-code-badge">${skill.code}</span>
				<button type="button" class="tag-remove" data-skill-id="${skill.id}">
					<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<line x1="18" y1="6" x2="6" y2="18"></line>
						<line x1="6" y1="6" x2="18" y2="18"></line>
					</svg>
				</button>
				<input type="hidden" name="skills[]" value="${skill.id}">
			</div>
		`
            )
            .join("");

        // Add remove handlers
        selectedSkillTags.querySelectorAll(".tag-remove").forEach((btn) => {
            btn.addEventListener("click", (e) => {
                e.stopPropagation();
                const skillId = parseInt(btn.dataset.skillId);
                const skill = allSkills.find((s) => s.id === skillId);
                toggleSkill(skill);
            });
        });
    }

    // Show/hide skill dropdown
    if (skillSelectInput) {
        skillSelectInput.addEventListener("click", () => {
            skillDropdown.style.display =
                skillDropdown.style.display === "none" ? "block" : "none";
        });

        skillSearch.addEventListener("input", (e) => {
            renderSkillList(e.target.value);
        });

        // Close dropdown when clicking outside
        document.addEventListener("click", (e) => {
            if (
                !skillSelectInput.contains(e.target) &&
                !skillDropdown.contains(e.target)
            ) {
                skillDropdown.style.display = "none";
            }
        });
    }

    // === MARKDOWN EDITOR ===
    const mdTextarea = document.getElementById("fullDescription");
    const mdToolbar = document.querySelector(".markdown-toolbar");
    const mdPreview = document.getElementById("mdPreview");
    const mdPreviewContent = document.getElementById("mdPreviewContent");
    const mdPreviewToggle = document.getElementById("mdPreviewToggle");

    let isPreviewOpen = false;

    if (mdTextarea && mdToolbar) {
        const actions = {
            bold: () => wrapSelection("**", "**", "texte en gras"),
            italic: () => wrapSelection("*", "*", "texte en italique"),
            strikethrough: () => wrapSelection("~~", "~~", "texte barré"),
            heading: () => insertAtLineStart("## ", "Titre"),
            code: () => wrapSelection("`", "`", "code"),
            codeblock: () => wrapSelection("```\n", "\n```", "votre code ici"),
            link: () => wrapSelection("[", "](https://)", "texte du lien"),
            image: () => wrapSelection("![", "](https://)", "description"),
            ul: () => insertAtLineStart("- ", "élément de liste"),
            ol: () => insertAtLineStart("1. ", "élément de liste"),
            quote: () => insertAtLineStart("> ", "citation"),
            table: () =>
                insertText(
                    "\n| Colonne 1 | Colonne 2 |\n|-----------|------------|\n| Cellule 1 | Cellule 2 |\n"
                ),
            hr: () => insertText("\n---\n"),
        };

        function wrapSelection(before, after, placeholder) {
            const start = mdTextarea.selectionStart;
            const end = mdTextarea.selectionEnd;
            const selectedText = mdTextarea.value.substring(start, end);
            const text = selectedText || placeholder;
            const newText = before + text + after;

            mdTextarea.setRangeText(newText, start, end, "end");
            mdTextarea.focus();

            if (!selectedText) {
                mdTextarea.setSelectionRange(
                    start + before.length,
                    start + before.length + text.length
                );
            }
            if (isPreviewOpen) {
                renderMarkdownToPreview();
            }
        }

        function insertAtLineStart(prefix, placeholder) {
            const start = mdTextarea.selectionStart;
            const currentLineStart =
                mdTextarea.value.substring(0, start).lastIndexOf("\n") + 1;
            const currentLineEnd = mdTextarea.value.indexOf("\n", start);
            const lineEnd =
                currentLineEnd === -1
                    ? mdTextarea.value.length
                    : currentLineEnd;
            const currentLine = mdTextarea.value.substring(
                currentLineStart,
                lineEnd
            );

            if (currentLine.trim() === "") {
                mdTextarea.setRangeText(
                    prefix + placeholder,
                    start,
                    start,
                    "end"
                );
                mdTextarea.setSelectionRange(
                    start + prefix.length,
                    start + prefix.length + placeholder.length
                );
            } else {
                mdTextarea.setRangeText(
                    prefix,
                    currentLineStart,
                    currentLineStart,
                    "end"
                );
            }
            mdTextarea.focus();
            if (isPreviewOpen) {
                renderMarkdownToPreview();
            }
        }

        function insertText(text) {
            const start = mdTextarea.selectionStart;
            mdTextarea.setRangeText(text, start, start, "end");
            mdTextarea.focus();
            if (isPreviewOpen) {
                renderMarkdownToPreview();
            }
        }

        mdToolbar.querySelectorAll(".md-btn").forEach((btn) => {
            btn.addEventListener("click", (e) => {
                e.preventDefault();
                const action = btn.dataset.action;
                if (actions[action]) {
                    actions[action]();
                }
            });
        });

        mdTextarea.addEventListener("keydown", (e) => {
            if (e.ctrlKey || e.metaKey) {
                if (e.key === "b") {
                    e.preventDefault();
                    actions.bold();
                } else if (e.key === "i") {
                    e.preventDefault();
                    actions.italic();
                }
            }
        });

        if (mdPreviewToggle) {
            mdPreviewToggle.addEventListener("click", (e) => {
                e.preventDefault();
                togglePreview();
            });
        }

        if (document.querySelector(".md-preview-close")) {
            document
                .querySelector(".md-preview-close")
                .addEventListener("click", () => {
                    mdPreview.style.display = "none";
                    isPreviewOpen = false;
                });
        }

        function togglePreview() {
            if (mdPreview.style.display === "none") {
                const markdown = mdTextarea.value;
                renderMarkdownToPreview();
                mdPreview.style.display = "block";
                isPreviewOpen = true;
            } else {
                mdPreview.style.display = "none";
                isPreviewOpen = false;
            }
        }

        mdTextarea.addEventListener("input", function () {
            if (isPreviewOpen) {
                renderMarkdownToPreview();
            }
        });

        function renderMarkdownToPreview() {
            mdPreviewContent.innerHTML = renderMarkdown(mdTextarea.value);
        }

        function renderMarkdown(md) {
            let html = md;
            html = html.replace(/</g, "&lt;").replace(/>/g, "&gt;");

            const CODE_BLOCK_PLACEHOLDER = "%%%CODEBLOCK%%%";
            let codeBlocks = [];
            html = html.replace(/```([\s\S]*?)```/g, function (match, code) {
                codeBlocks.push(code);
                return CODE_BLOCK_PLACEHOLDER;
            });

            html = html.replace(
                /!\[([^\]]*)\]\(([^)\s]+)(?:\s+"([^"]+)")?\)/g,
                function (match, alt, url, title) {
                    let attrs = 'alt="' + alt.replace(/"/g, "&quot;") + '"';
                    if (title)
                        attrs +=
                            ' title="' + title.replace(/"/g, "&quot;") + '"';
                    return (
                        '<img src="' +
                        url +
                        '" ' +
                        attrs +
                        ' style="max-width: 100%; display: block; margin: 1em 0;" />'
                    );
                }
            );

            html = html.replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>");
            html = html.replace(/\*([^*]+)\*/g, "<em>$1</em>");
            html = html.replace(/~~([^~]+)~~/g, "<del>$1</del>");
            html = html.replace(/`([^`]+)`/g, "<code>$1</code>");
            html = html.replace(/^### (.+)$/gm, "<h3>$1</h3>");
            html = html.replace(/^## (.+)$/gm, "<h2>$1</h2>");
            html = html.replace(/^# (.+)$/gm, "<h1>$1</h1>");
            html = html.replace(
                /\[([^\]]+)\]\(([^)]+)\)/g,
                '<a href="$2" target="_blank">$1</a>'
            );
            html = html.replace(/^\- (.+)$/gm, "<li>$1</li>");
            html = html.replace(/(<li>.*<\/li>)/s, "<ul>$1</ul>");
            html = html.replace(/^\d+\. (.+)$/gm, "<li>$1</li>");
            html = html.replace(/^\s*---+\s*$/gm, "<hr />");

            let idx = 0;
            html = html.replace(
                new RegExp(CODE_BLOCK_PLACEHOLDER, "g"),
                function () {
                    const code = codeBlocks[idx++];
                    return (
                        "<pre><code>" +
                        code.replace(/</g, "&lt;").replace(/>/g, "&gt;") +
                        "</code></pre>"
                    );
                }
            );

            html = html.replace(/\n/g, "<br>");

            return html;
        }
    }

    // === IMAGE SELECTION (Project main image) ===
    const selectImageBtn = document.getElementById("selectImageBtn");
    const imageInput = document.getElementById("image");
    const imagePreview = document.getElementById("imagePreview");
    const removeImageBtn = document.getElementById("removeImage");

    if (selectImageBtn) {
        selectImageBtn.addEventListener("click", () => {
            openMediaSelector("image", "single", (selectedFiles) => {
                if (selectedFiles.length > 0) {
                    const file = selectedFiles[0];
                    imageInput.value = file.name;
                    updateImagePreview(file.url);
                }
            });
        });
    }

    if (removeImageBtn) {
        removeImageBtn.addEventListener("click", () => {
            imageInput.value = "";
            imagePreview.innerHTML = `
				<div class="image-placeholder">
					<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
						<circle cx="8.5" cy="8.5" r="1.5"></circle>
						<polyline points="21 15 16 10 5 21"></polyline>
					</svg>
					<p>Aucune image sélectionnée</p>
				</div>
			`;
        });
    }

    function updateImagePreview(url) {
        imagePreview.innerHTML = `
			<img src="${url}" alt="Aperçu">
			<button type="button" class="image-remove-btn" id="removeImage">
				<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
					<line x1="18" y1="6" x2="6" y2="18"></line>
					<line x1="6" y1="6" x2="18" y2="18"></line>
				</svg>
			</button>
		`;

        const newRemoveBtn = document.getElementById("removeImage");
        if (newRemoveBtn) {
            newRemoveBtn.addEventListener("click", () => {
                imageInput.value = "";
                imagePreview.innerHTML = `
					<div class="image-placeholder">
						<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
							<rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
							<circle cx="8.5" cy="8.5" r="1.5"></circle>
							<polyline points="21 15 16 10 5 21"></polyline>
						</svg>
						<p>Aucune image sélectionnée</p>
					</div>
				`;
            });
        }
    }

    // === PROJECT GALLERY (multiple images) ===
    const selectGalleryImagesBtn = document.getElementById(
        "selectGalleryImagesBtn"
    );
    const projectGalleryGrid = document.getElementById("projectGalleryGrid");

    // Extract project ID from URL path (e.g., /admin/projects/5/edit)
    const pathParts = window.location.pathname.split("/");
    const projectsIndex = pathParts.indexOf("projects");
    const projectId =
        projectsIndex >= 0 &&
        pathParts[projectsIndex + 1] &&
        pathParts[projectsIndex + 1] !== "new"
            ? pathParts[projectsIndex + 1]
            : null;

    if (selectGalleryImagesBtn && projectId) {
        loadProjectGallery();

        selectGalleryImagesBtn.addEventListener("click", () => {
            openMediaSelector("image", "multiple", (selectedFiles) => {
                selectedFiles.forEach((file) => {
                    addImageToProject(file.name);
                });
            });
        });
    }

    function loadProjectGallery() {
        if (!projectId) return;

        fetch(`/admin/project/${projectId}/images`)
            .then((response) => response.json())
            .then((images) => {
                if (images.length === 0) {
                    projectGalleryGrid.innerHTML =
                        '<div class="no-images">Aucune image dans le carrousel</div>';
                } else {
                    projectGalleryGrid.innerHTML = images
                        .map(
                            (img) => `
						<div class="gallery-image-item" data-image-id="${img.id}">
							<img src="${img.url}" alt="">
							<button type="button" class="gallery-image-remove" data-image-id="${img.id}">
								<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
									<line x1="18" y1="6" x2="6" y2="18"></line>
									<line x1="6" y1="6" x2="18" y2="18"></line>
								</svg>
							</button>
						</div>
					`
                        )
                        .join("");

                    projectGalleryGrid
                        .querySelectorAll(".gallery-image-remove")
                        .forEach((btn) => {
                            btn.addEventListener("click", () => {
                                const imageId = btn.dataset.imageId;
                                removeImageFromProject(imageId);
                            });
                        });
                }
            })
            .catch((error) => {
                console.error("Error loading gallery:", error);
                projectGalleryGrid.innerHTML =
                    '<div class="error-text">Erreur lors du chargement</div>';
            });
    }

    function addImageToProject(filename) {
        fetch(`/admin/project/${projectId}/images/add`, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: `filename=${encodeURIComponent(filename)}`,
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.success) {
                    loadProjectGallery();
                } else {
                    alert("Erreur: " + data.error);
                }
            })
            .catch((error) => {
                console.error("Error adding image:", error);
                alert("Erreur lors de l'ajout de l'image");
            });
    }

    function removeImageFromProject(imageId) {
        if (!confirm("Supprimer cette image du carrousel ?")) return;

        fetch(`/admin/project/${projectId}/images/${imageId}`, {
            method: "DELETE",
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.success) {
                    loadProjectGallery();
                } else {
                    alert("Erreur: " + data.error);
                }
            })
            .catch((error) => {
                console.error("Error removing image:", error);
                alert("Erreur lors de la suppression");
            });
    }

    // === PROJECT FILES ===
    const selectFilesBtn = document.getElementById("selectFilesBtn");
    const projectFilesList = document.getElementById("projectFilesList");

    if (selectFilesBtn && projectId) {
        loadProjectFiles();

        selectFilesBtn.addEventListener("click", () => {
            openMediaSelector("file", "multiple", (selectedFiles) => {
                selectedFiles.forEach((file) => {
                    attachFileToProject(file.name);
                });
            });
        });
    }

    function loadProjectFiles() {
        if (!projectId) return;

        fetch(`/admin/project/${projectId}/files`)
            .then((response) => response.json())
            .then((files) => {
                if (files.length === 0) {
                    projectFilesList.innerHTML =
                        '<div class="no-files">Aucun fichier attaché</div>';
                } else {
                    projectFilesList.innerHTML = files
                        .map(
                            (file) => `
						<div class="project-file-item" data-file-id="${file.id}">
							<div class="file-icon ${file.fileType}">
								${file.icon}
							</div>
							<div class="file-info">
								<div class="file-name">${file.originalName}</div>
								<div class="file-meta">${file.fileSizeFormatted} • ${file.fileType}</div>
							</div>
							<a href="${file.url}" target="_blank" class="file-download" title="Télécharger">
								<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
									<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
									<polyline points="7 10 12 15 17 10"></polyline>
									<line x1="12" y1="15" x2="12" y2="3"></line>
								</svg>
							</a>
							<button type="button" class="file-remove" data-file-id="${file.id}">
								<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
									<line x1="18" y1="6" x2="6" y2="18"></line>
									<line x1="6" y1="6" x2="18" y2="18"></line>
								</svg>
							</button>
						</div>
					`
                        )
                        .join("");

                    projectFilesList
                        .querySelectorAll(".file-remove")
                        .forEach((btn) => {
                            btn.addEventListener("click", () => {
                                const fileId = btn.dataset.fileId;
                                removeFileFromProject(fileId);
                            });
                        });
                }
            })
            .catch((error) => {
                console.error("Error loading files:", error);
                projectFilesList.innerHTML =
                    '<div class="error-text">Erreur lors du chargement</div>';
            });
    }

    function attachFileToProject(filename) {
        fetch(`/admin/project/${projectId}/files/attach`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ filename: filename }),
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.success) {
                    loadProjectFiles();
                } else {
                    alert("Erreur: " + data.error);
                }
            })
            .catch((error) => {
                console.error("Error attaching file:", error);
                alert("Erreur lors de l'attachement du fichier");
            });
    }

    function removeFileFromProject(fileId) {
        if (!confirm("Détacher ce fichier du projet ?")) return;

        fetch(`/admin/project/${projectId}/files/${fileId}`, {
            method: "DELETE",
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.success) {
                    loadProjectFiles();
                } else {
                    alert("Erreur: " + data.error);
                }
            })
            .catch((error) => {
                console.error("Error removing file:", error);
                alert("Erreur lors de la suppression");
            });
    }

    // === MEDIA SELECTOR MODAL ===
    const mediaSelectorModal = document.getElementById("mediaSelectorModal");
    const modalTitle = document.getElementById("modalTitle");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const modalCancelBtn = document.getElementById("modalCancelBtn");
    const modalValidateBtn = document.getElementById("modalValidateBtn");
    const modalGalleryGrid = document.getElementById("modalGalleryGrid");
    const modalFooter = document.getElementById("modalFooter");
    const selectedCount = document.getElementById("selectedCount");

    // Modal tabs
    const modalTabs = document.querySelectorAll(".modal-tab");
    const galleryTab = document.getElementById("galleryTab");
    const uploadTab = document.getElementById("uploadTab");

    // Upload elements
    const modalDropZone = document.getElementById("modalDropZone");
    const modalSelectFileBtn = document.getElementById("modalSelectFileBtn");
    const modalFileInput = document.getElementById("modalFileInput");
    const modalUploadProgress = document.getElementById("modalUploadProgress");
    const modalProgressFill = document.getElementById("modalProgressFill");
    const modalUploadStatus = document.getElementById("modalUploadStatus");
    const modalUploadHint = document.getElementById("modalUploadHint");

    let currentModalMode = "single"; // 'single' or 'multiple'
    let currentFileType = "image"; // 'image' or 'file'
    let selectedModalFiles = [];
    let modalCallback = null;

    function openMediaSelector(fileType, mode, callback) {
        currentFileType = fileType;
        currentModalMode = mode;
        modalCallback = callback;
        selectedModalFiles = [];

        modalTitle.textContent =
            fileType === "image"
                ? mode === "single"
                    ? "Sélectionner une image"
                    : "Sélectionner des images"
                : mode === "single"
                ? "Sélectionner un fichier"
                : "Sélectionner des fichiers";

        modalUploadHint.textContent =
            fileType === "image"
                ? "JPG, PNG, GIF, WebP ou SVG (Max 5MB)"
                : "PDF, DOC, DOCX, XLS, XLSX, ZIP, TXT (Max 20MB)";

        modalFooter.style.display = mode === "multiple" ? "flex" : "none";

        mediaSelectorModal.classList.add("active");
        loadModalGallery();
    }

    function closeMediaSelector() {
        mediaSelectorModal.classList.remove("active");
        selectedModalFiles = [];
    }

    if (closeModalBtn) {
        closeModalBtn.addEventListener("click", closeMediaSelector);
    }

    if (modalCancelBtn) {
        modalCancelBtn.addEventListener("click", closeMediaSelector);
    }

    if (modalValidateBtn) {
        modalValidateBtn.addEventListener("click", () => {
            if (modalCallback) {
                modalCallback(selectedModalFiles);
            }
            closeMediaSelector();
        });
    }

    // Modal tabs
    modalTabs.forEach((tab) => {
        tab.addEventListener("click", () => {
            const tabName = tab.dataset.tab;

            modalTabs.forEach((t) => t.classList.remove("active"));
            tab.classList.add("active");

            if (tabName === "gallery") {
                galleryTab.classList.add("active");
                uploadTab.classList.remove("active");
            } else {
                uploadTab.classList.add("active");
                galleryTab.classList.remove("active");
            }
        });
    });

    function loadModalGallery() {
        modalGalleryGrid.innerHTML =
            '<div class="loading-spinner">Chargement...</div>';

        const endpoint =
            currentFileType === "image"
                ? "/admin/media/api/images"
                : "/admin/media/api/files";

        fetch(endpoint)
            .then((response) => response.json())
            .then((data) => {
                const files = data.images || data.files || [];

                if (files.length === 0) {
                    modalGalleryGrid.innerHTML =
                        '<div class="no-files">Aucun fichier disponible</div>';
                    return;
                }

                modalGalleryGrid.innerHTML = files
                    .map((file) => {
                        const isImage =
                            file.type === "image" ||
                            file.url.match(/\.(jpg|jpeg|png|gif|webp|svg)$/i);
                        return `
						<div class="modal-gallery-item" data-filename="${file.name}" data-url="${
                            file.url
                        }">
							${
                                isImage
                                    ? `<img src="${file.url}" alt="${file.name}">`
                                    : `<div class="file-icon">
									<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
										<path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path>
										<polyline points="13 2 13 9 20 9"></polyline>
									</svg>
								</div>`
                            }
							<div class="file-name">${file.name}</div>
						</div>
					`;
                    })
                    .join("");

                modalGalleryGrid
                    .querySelectorAll(".modal-gallery-item")
                    .forEach((item) => {
                        item.addEventListener("click", () => {
                            const filename = item.dataset.filename;
                            const url = item.dataset.url;

                            if (currentModalMode === "single") {
                                selectedModalFiles = [
                                    { name: filename, url: url },
                                ];
                                if (modalCallback) {
                                    modalCallback(selectedModalFiles);
                                }
                                closeMediaSelector();
                            } else {
                                // Multiple selection
                                const index = selectedModalFiles.findIndex(
                                    (f) => f.name === filename
                                );
                                if (index > -1) {
                                    selectedModalFiles.splice(index, 1);
                                    item.classList.remove("selected");
                                } else {
                                    selectedModalFiles.push({
                                        name: filename,
                                        url: url,
                                    });
                                    item.classList.add("selected");
                                }
                                updateSelectedCount();
                            }
                        });
                    });
            })
            .catch((error) => {
                console.error("Error loading gallery:", error);
                modalGalleryGrid.innerHTML =
                    '<div class="error-text">Erreur lors du chargement</div>';
            });
    }

    function updateSelectedCount() {
        if (selectedModalFiles.length > 0) {
            selectedCount.textContent = `(${selectedModalFiles.length})`;
        } else {
            selectedCount.textContent = "";
        }
    }

    // Upload functionality
    if (modalSelectFileBtn) {
        modalSelectFileBtn.addEventListener("click", () => {
            modalFileInput.click();
        });
    }

    if (modalFileInput) {
        modalFileInput.addEventListener("change", (e) => {
            const files = Array.from(e.target.files);
            if (files.length > 0) {
                uploadFiles(files);
            }
        });
    }

    if (modalDropZone) {
        modalDropZone.addEventListener("dragover", (e) => {
            e.preventDefault();
            modalDropZone.classList.add("drag-over");
        });

        modalDropZone.addEventListener("dragleave", () => {
            modalDropZone.classList.remove("drag-over");
        });

        modalDropZone.addEventListener("drop", (e) => {
            e.preventDefault();
            modalDropZone.classList.remove("drag-over");

            const files = Array.from(e.dataTransfer.files);
            if (files.length > 0) {
                uploadFiles(files);
            }
        });
    }

    function uploadFiles(files) {
        modalDropZone.style.display = "none";
        modalUploadProgress.style.display = "block";

        let completed = 0;
        const total = files.length;

        files.forEach((file, index) => {
            const formData = new FormData();
            formData.append("file", file);
            formData.append("fileType", currentFileType);

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
                                modalFileInput.value = ""; // Reset file input

                                // Switch to gallery tab and reload
                                modalTabs[0].click();
                                loadModalGallery();
                            }, 500);
                        }
                    } else {
                        completed++;
                        alert(
                            "Erreur upload: " +
                                (data.error || "Erreur inconnue")
                        );

                        // Si tous les fichiers sont traités (avec succès ou erreur)
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

                    // Si tous les fichiers sont traités
                    if (completed === total) {
                        modalUploadProgress.style.display = "none";
                        modalDropZone.style.display = "flex";
                        modalProgressFill.style.width = "0%";
                        modalFileInput.value = "";
                    }
                });
        });
    }

    // Close modal when clicking outside
    mediaSelectorModal.addEventListener("click", (e) => {
        if (e.target === mediaSelectorModal) {
            closeMediaSelector();
        }
    });

    // === PREUVES MANAGEMENT ===
    const preuvesSection = document.getElementById("preuvesSection");
    const preuvesList = document.getElementById("preuvesList");

    if (preuvesSection && projectId) {
        const preuveAddBtn = document.getElementById("preuveAddBtn");
        const preuveTitleInput = document.getElementById("preuveTitle");
        const preuveDescInput = document.getElementById("preuveDescription");
        const preuveSkillSelect = document.getElementById("preuveSkill");
        const preuveFilenameInput = document.getElementById("preuveFilename");
        const preuveImagePreview = document.getElementById("preuveImagePreview");
        const preuveImagePreviewImg = document.getElementById("preuveImagePreviewImg");
        const preuveImageRemoveBtn = document.getElementById("preuveImageRemoveBtn");
        const preuveSelectImageBtn = document.getElementById("preuveSelectImageBtn");

        // Load existing preuves
        loadPreuves();

        // Select image for preuve
        preuveSelectImageBtn.addEventListener("click", () => {
            openMediaSelector("image", "single", (selectedFiles) => {
                if (selectedFiles.length > 0) {
                    const file = selectedFiles[0];
                    preuveFilenameInput.value = file.name;
                    preuveImagePreviewImg.src = file.url;
                    preuveImagePreview.style.display = "block";
                }
            });
        });

        // Remove selected preuve image
        preuveImageRemoveBtn.addEventListener("click", () => {
            preuveFilenameInput.value = "";
            preuveImagePreviewImg.src = "";
            preuveImagePreview.style.display = "none";
        });

        // Add preuve
        preuveAddBtn.addEventListener("click", () => {
            const title = preuveTitleInput.value.trim();
            const description = preuveDescInput.value.trim();
            const skillId = preuveSkillSelect.value;
            const filename = preuveFilenameInput.value;

            if (!title) {
                alert("Veuillez saisir un titre pour la preuve");
                preuveTitleInput.focus();
                return;
            }
            if (!skillId) {
                alert("Veuillez sélectionner une compétence");
                preuveSkillSelect.focus();
                return;
            }
            if (!filename) {
                alert("Veuillez sélectionner une image");
                return;
            }

            preuveAddBtn.disabled = true;
            preuveAddBtn.textContent = "Ajout en cours...";

            const formData = new URLSearchParams();
            formData.append("title", title);
            formData.append("description", description);
            formData.append("skillId", skillId);
            formData.append("filename", filename);

            fetch(`/admin/project/${projectId}/preuves/add`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: formData.toString(),
            })
                .then((response) => response.json())
                .then((data) => {
                    if (data.success) {
                        // Reset form
                        preuveTitleInput.value = "";
                        preuveDescInput.value = "";
                        preuveSkillSelect.value = "";
                        preuveFilenameInput.value = "";
                        preuveImagePreviewImg.src = "";
                        preuveImagePreview.style.display = "none";

                        loadPreuves();
                    } else {
                        alert("Erreur: " + (data.error || "Erreur inconnue"));
                    }
                })
                .catch((error) => {
                    console.error("Error adding preuve:", error);
                    alert("Erreur lors de l'ajout de la preuve");
                })
                .finally(() => {
                    preuveAddBtn.disabled = false;
                    preuveAddBtn.innerHTML = `
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="12" y1="5" x2="12" y2="19"></line>
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                        </svg>
                        Ajouter la preuve
                    `;
                });
        });

        function loadPreuves() {
            fetch(`/admin/project/${projectId}/preuves`)
                .then((response) => response.json())
                .then((preuves) => {
                    if (preuves.length === 0) {
                        preuvesList.innerHTML =
                            '<div class="no-files" style="padding: 2rem; text-align: center; color: var(--text-secondary);">Aucune preuve ajoutée</div>';
                        return;
                    }

                    // Group by skill
                    const grouped = {};
                    preuves.forEach((p) => {
                        const key = p.skillId || "none";
                        if (!grouped[key]) {
                            grouped[key] = {
                                skillName: p.skillName || "Sans compétence",
                                skillCode: p.skillCode || "",
                                items: [],
                            };
                        }
                        grouped[key].items.push(p);
                    });

                    let html = "";
                    for (const [skillId, group] of Object.entries(grouped)) {
                        html += `
                            <div class="preuves-skill-group">
                                <div class="preuves-skill-header">
                                    ${group.skillCode ? `<span class="skill-code-badge">${group.skillCode}</span>` : ""}
                                    <span>${group.skillName}</span>
                                    <span class="preuves-count">${group.items.length} preuve${group.items.length > 1 ? "s" : ""}</span>
                                </div>
                                <div class="preuves-grid">
                                    ${group.items
                                        .map(
                                            (p) => `
                                        <div class="preuve-card-admin">
                                            <div class="preuve-card-image">
                                                <img src="${p.url}" alt="${p.title}">
                                            </div>
                                            <div class="preuve-card-info">
                                                <strong>${p.title}</strong>
                                                ${p.description ? `<small>${p.description}</small>` : ""}
                                            </div>
                                            <button type="button" class="preuve-delete-btn" data-preuve-id="${p.id}" title="Supprimer">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                </svg>
                                            </button>
                                        </div>
                                    `
                                        )
                                        .join("")}
                                </div>
                            </div>
                        `;
                    }

                    preuvesList.innerHTML = html;

                    // Add delete handlers
                    preuvesList.querySelectorAll(".preuve-delete-btn").forEach((btn) => {
                        btn.addEventListener("click", () => {
                            if (!confirm("Supprimer cette preuve ?")) return;
                            const preuveId = btn.dataset.preuveId;
                            deletePreuve(preuveId);
                        });
                    });
                })
                .catch((error) => {
                    console.error("Error loading preuves:", error);
                    preuvesList.innerHTML =
                        '<div class="error-text">Erreur lors du chargement des preuves</div>';
                });
        }

        function deletePreuve(preuveId) {
            fetch(`/admin/project/${projectId}/preuves/${preuveId}`, {
                method: "DELETE",
            })
                .then((response) => response.json())
                .then((data) => {
                    if (data.success) {
                        loadPreuves();
                    } else {
                        alert("Erreur: " + (data.error || "Erreur inconnue"));
                    }
                })
                .catch((error) => {
                    console.error("Error deleting preuve:", error);
                    alert("Erreur lors de la suppression");
                });
        }
    }
});
