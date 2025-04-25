$(function () {
  let isDragging = false;
  let startX = 0;
  let startY = 0;
  let intensity = 50;
  const minIntensity = 10;
  const maxIntensity = 100;
  let index = 0;

  const colors = ["#FF6633",
        "#FFB399",
        "#FF33FF",
        "#FFFF99",
        "#00B3E6",
        "#E6B333",
        "#3366E6",
        "#999966",
        "#809980",
        "#E6FF80",
        "#1AFF33"];

  $(document).on("mousedown", function (e) {
    isDragging = true;
    startX = e.pageX;
    startY = e.pageY;
  });

  $(document).on("mouseup", function () {
    isDragging = false;
  });

  $(document).on("mousemove", function (e) {
    const x = e.pageX;
    const y = e.pageY;
    const w = $(window).width();
    const h = $(window).height();

    const xPercent = (x / w) * 100;
    const yPercent = (y / h) * 100;

    const dx = x - startX;
    const dy = y - startY;

    const distance = Math.sqrt(dx * dx + dy * dy);

    if(!isDragging) {
      let directionFactor = 0;
      if (dx > 0) directionFactor += 1;  
      if (dx < 0) directionFactor -= 1;  
      if (dy < 0) directionFactor += 1;  
      if (dy > 0) directionFactor -= 1; 
      
      intensity += directionFactor * (distance / 100);
      intensity = Math.max(minIntensity, Math.min(maxIntensity, intensity));
  
      $("body").css("background",
        `radial-gradient(circle at ${xPercent}% ${yPercent}%, rgb(255, 0, 183) 0%, rgba(0, 0, 0, 1) ${intensity}%)`);
        return;
    }  

    timeoutId = setTimeout(function () {
      if (dx > 0 || dy < 0) {
        index = (index + 1) % colors.length;
      } else if (dx < 0 || dy > 0) {
        index = (index - 1 + colors.length) % colors.length;
      }
    } ,1000);

    intensity += (Math.abs(dx) + Math.abs(dy)) / 100;
    intensity = Math.max(minIntensity, Math.min(maxIntensity, intensity));
    
    $(this).delay(1000).queue(function() {
      $("body").css("background", 
        `radial-gradient(circle at ${xPercent}% ${yPercent}%, ${colors[index]} 0%, rgba(0, 0, 0, 1) ${intensity}%)`),
      $(this).dequeue();
      })
    }); 
});