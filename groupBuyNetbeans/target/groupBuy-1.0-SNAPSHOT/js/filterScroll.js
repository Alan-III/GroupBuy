const sidemenu = document.getElementById("side-menu");
// -----------------scroll
const handleOnWheelVertical = (e, trackElement) => {
  e.preventDefault();

  const delta = Math.max(-1, Math.min(1, e.deltaY || -e.wheelDelta || e.detail));
  const maxDelta = window.innerHeight / 2;
  const percentage = (delta * 50 / maxDelta) * -100;
  const prevPercentage = parseFloat(trackElement.dataset.prevPercentage) || 0;
  const nextPercentageUnconstrained = prevPercentage + percentage;
  const nextPercentage = Math.max(Math.min(nextPercentageUnconstrained, 0), -60);
  trackElement.dataset.prevPercentage = nextPercentage;
  trackElement.dataset.percentage = nextPercentage;

  trackElement.animate(
    {
      transform: `translate(0%, ${nextPercentage}%)`
    },
    { duration: 1200, fill: "forwards" }
  );

  for (const image of trackElement.getElementsByClassName("image")) {
    image.animate(
      {
        objectPosition: `center ${80 + nextPercentage / 1.4}%`
      },
      { duration: 1200, fill: "forwards" }
    );
  }
};

sidemenu.addEventListener("wheel", e => handleOnWheelVertical(e, sidemenu), { passive: false });