const track = document.getElementById("image-track");
const track2 = document.getElementById("image-track2");
const trackContainer = document.getElementById("trackcontainer");
const trackContainer2 = document.getElementById("trackcontainer2");
const sidemenu = document.getElementById("side-menu");
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

  if (lastChildRect.right + nextPercentage +200 < trackContainerRect.right && nextPercentage < prevPercentage) {
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
trackcontainer.addEventListener("wheel", e => handleOnWheelHorizontal(e, track), { passive: false });
trackcontainer2.addEventListener("wheel", e => handleOnWheelHorizontal(e, track2), { passive: false });
sidemenu.addEventListener("wheel", e => handleOnWheelVertical(e, sidemenu), { passive: false });
//// -----------------click drag
//const handleOnDown = e => track.dataset.mouseDownAt = e.clientX;
//
//const handleOnUp = () => {
//  track.dataset.mouseDownAt = "0";  
//  track.dataset.prevPercentage = track.dataset.percentage;
//}
//
//const handleOnMove = e => {
//  if(track.dataset.mouseDownAt === "0") return;
//  
//  const mouseDelta = parseFloat(track.dataset.mouseDownAt) - e.clientX,
//        maxDelta = window.innerWidth / 2;
//  
//  const percentage = (mouseDelta / maxDelta) * -100,
//        nextPercentageUnconstrained = parseFloat(track.dataset.prevPercentage) + percentage,
//        nextPercentage = Math.max(Math.min(nextPercentageUnconstrained, 0), -60);
//  
//  track.dataset.percentage = nextPercentage;
//  
//  track.animate({
//    transform: `translate(${nextPercentage}%, -50%)`
//  }, { duration: 1200, fill: "forwards" });
//  
//  for(const image of track.getElementsByClassName("image")) {
//    image.animate({
//      objectPosition: `${80 + nextPercentage/1.4}% center`
//    }, { duration: 1200, fill: "forwards" });
//  }
//}

/* -- Had to add extra lines for touch events -- */


//window.onmousedown = e => handleOnDown(e);

//window.ontouchstart = e => handleOnDown(e.touches[0]);

//window.onmouseup = e => handleOnUp(e);

//window.ontouchend = e => handleOnUp(e.touches[0]);

//window.onmousemove = e => handleOnMove(e);

//window.ontouchmove = e => handleOnMove(e.touches[0]);