// Dropdown menu structure
const menuData = {
    "Menu 1": ["Submenu 1.1", "Submenu 1.2", "Submenu 1.3"],
    "Menu 2": ["Submenu 2.1", "Submenu 2.2", "Submenu 2.3", "Submenu 2.4"],
    "Menu 3": ["Submenu 3.1", "Submenu 3.2", "Submenu 3.3", "Submenu 3.4", "Submenu 3.5"],
    "Menu 4": ["Submenu 4.1", "Submenu 4.2", "Submenu 4.3"],
    "Menu 5": ["Submenu 5.1", "Submenu 5.2", "Submenu 5.3", "Submenu 5.4"]
};

function createDropdown(menuData) {
    const container = document.getElementById('dropdown-container');

    const dropdown = document.createElement('div');
    dropdown.className = 'dropdown';

    const mainButton = document.createElement('button');
    mainButton.textContent = 'Dropdown';
    dropdown.appendChild(mainButton);

    const dropdownContent = document.createElement('div');
    dropdownContent.className = 'dropdown-content';

    Object.entries(menuData).forEach(([menu, submenus]) => {
        const submenu = document.createElement('div');
        submenu.className = 'submenu';

        const submenuButton = document.createElement('button');
        submenuButton.textContent = menu;
        submenu.appendChild(submenuButton);

        const submenuContent = document.createElement('div');
        submenuContent.className = 'submenu-content';

        submenus.forEach(item => {
            const submenuItem = document.createElement('a');
            submenuItem.href = '#';
            submenuItem.textContent = item;
            submenuContent.appendChild(submenuItem);
        });

        submenu.appendChild(submenuContent);
        dropdownContent.appendChild(submenu);

        submenuButton.addEventListener('click', (e) => {
            e.stopPropagation();
            closeOtherSubmenus(submenuContent);
            submenuContent.style.display = submenuContent.style.display === 'block' ? 'none' : 'block';
        });
    });

    dropdown.appendChild(dropdownContent);
    container.appendChild(dropdown);

    mainButton.addEventListener('click', (e) => {
        e.stopPropagation();
        closeOtherSubmenus();
        dropdownContent.style.display = dropdownContent.style.display === 'block' ? 'none' : 'block';
    });

    document.addEventListener('click', () => {
        dropdownContent.style.display = 'none';
        closeOtherSubmenus();
    });

    function closeOtherSubmenus(except = null) {
        document.querySelectorAll('.submenu-content').forEach(menu => {
            if (menu !== except) menu.style.display = 'none';
        });
    }
}
createDropdown(menuData);
