// Get all the navigation links
const navLinks = document.querySelectorAll('.nav-link');

// Get all the sections
const sections = document.querySelectorAll('section');

// Add a scroll event listener to the window object
window.addEventListener('scroll', () => {
  // Loop through each section
  sections.forEach((section, index) => {
    // Get the position and dimensions of the section
    const { top, height } = section.getBoundingClientRect();

    // Check if the section is currently in view
    if (top <= 500 && top + height > 0) {
      // Remove the "active" class from any previously highlighted navigation links
      navLinks.forEach((link) => {
        link.classList.remove('active');
      });

      // Add the "active" class to the corresponding navigation link
      navLinks[index].classList.add('active');
    }
  });
});
