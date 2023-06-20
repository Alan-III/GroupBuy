const track = document.getElementById("image-track");
const track2 = document.getElementById("image-track2");
const trackContainer = document.getElementById("trackcontainer");
const trackContainer2 = document.getElementById("trackcontainer2");
// -----------------scroll
const handleOnWheelHorizontal = (e, trackElement) => {
  e.preventDefault();

  const delta = Math.max(-1, Math.min(1, e.deltaY || -e.wheelDelta || e.detail));
  const maxDelta = window.innerWidth / 2;
  const percentage = (delta * 50 / maxDelta) * -100;
  const prevPercentage = parseFloat(trackElement.dataset.prevPercentage) || 0;
  const nextPercentageUnconstrained = prevPercentage + percentage;
  const nextPercentage = Math.min(nextPercentageUnconstrained, 0);
  
  // Check if the last child is in the middle of the screen
  const lastChild = trackElement.lastElementChild;
  const lastChildRect = lastChild.getBoundingClientRect();
  const trackContainerRect = trackContainer.getBoundingClientRect();

  if (lastChildRect.right + nextPercentage/2 + 400 < trackContainerRect.right && nextPercentage < prevPercentage) {
    // Stop scrolling if the last child is in the middle
  }
  else{
      trackElement.dataset.prevPercentage = nextPercentage;
      trackElement.dataset.percentage = nextPercentage;
  }

  trackElement.animate(
    {
      transform: `translate(${nextPercentage}%, 0%)`
    },
    { duration: 1200, fill: "forwards" }
  );

  for (const image of trackElement.getElementsByClassName("image")) {
    image.animate(
      {
        objectPosition: `${80 + nextPercentage / 1.4}% center`
      },
      { duration: 1200, fill: "forwards" }
    );
  }
};

trackcontainer.addEventListener("wheel", e => handleOnWheelHorizontal(e, track), { passive: false });
trackcontainer2.addEventListener("wheel", e => handleOnWheelHorizontal(e, track2), { passive: false });