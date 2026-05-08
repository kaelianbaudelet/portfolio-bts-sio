document.addEventListener("DOMContentLoaded", function () {
    const projectsGrid = document.getElementById("projectsGrid");
    const noResults = document.getElementById("noResults");
    const resultsCount = document.getElementById("resultsCount");
    const typeFilter = document.getElementById("typeFilter");
    const categoryFilter = document.getElementById("categoryFilter");
    const yearFilter = document.getElementById("yearFilter");
    const resetFiltersBtn = document.getElementById("resetFilters");

    if (!projectsGrid) return;

    const projectCards = Array.from(
        projectsGrid.querySelectorAll(".project-card")
    );

    // Populate year filter with unique years from projects
    function populateYearFilter() {
        const years = new Set();
        projectCards.forEach((card) => {
            const year = card.dataset.year;
            if (year) {
                years.add(year);
            }
        });

        // Sort years in descending order
        const sortedYears = Array.from(years).sort((a, b) => b - a);

        sortedYears.forEach((year) => {
            const option = document.createElement("option");
            option.value = year;
            option.textContent = year;
            yearFilter.appendChild(option);
        });
    }

    populateYearFilter();

    // Filter function
    function applyFilters() {
        const selectedType = typeFilter.value;
        const selectedCategory = categoryFilter.value;
        const selectedYear = yearFilter.value;

        let visibleCount = 0;

        projectCards.forEach((card) => {
            const cardType = card.dataset.type || "";
            const cardCategory = card.dataset.category || "";
            const cardYear = card.dataset.year || "";

            const matchesType =
                selectedType === "all" || cardType === selectedType;
            const matchesCategory =
                selectedCategory === "all" ||
                cardCategory === selectedCategory;
            const matchesYear =
                selectedYear === "all" || cardYear === selectedYear;

            if (matchesType && matchesCategory && matchesYear) {
                card.style.display = "";
                visibleCount++;
            } else {
                card.style.display = "none";
            }
        });

        // Show/hide reset button
        const isDefault = selectedType === "all" && selectedCategory === "all" && selectedYear === "all";
        resetFiltersBtn.style.display = isDefault ? "none" : "flex";

        // Update results count
        resultsCount.textContent = visibleCount;

        // Show/hide no results message
        if (visibleCount === 0) {
            noResults.style.display = "flex";
            projectsGrid.style.display = "none";
        } else {
            noResults.style.display = "none";
            projectsGrid.style.display = "grid";
        }
    }

    // Event listeners
    typeFilter.addEventListener("change", applyFilters);
    categoryFilter.addEventListener("change", applyFilters);
    yearFilter.addEventListener("change", applyFilters);

    resetFiltersBtn.addEventListener("click", function () {
        typeFilter.value = "all";
        categoryFilter.value = "all";
        yearFilter.value = "all";
        applyFilters();
    });

    // Initial count
    applyFilters();
});
