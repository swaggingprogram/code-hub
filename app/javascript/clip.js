window.addEventListener("load", () => {
  const clickButton = document.getElementById("clipping");

  clickButton.addEventListener("mouseover", function(){
    clickButton.style.color = '#00303e';
    clickButton.style.backgroundColor = '#999999'; 
  })

  clickButton.addEventListener('mouseout', function(){
    clickButton.removeAttribute("style", "background-color:#999999;");
    clickButton.removeAttribute("style", "color:#00303e;");
  })

  clickButton.addEventListener('click', function(){
    new ClipboardJS('.clip-btn');
    alert("コードをコピーしました");
  })
})