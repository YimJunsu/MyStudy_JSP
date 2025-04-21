function updateClock() {
  const now = new Date();
  const hours = now.getHours().toString().padStart(2, "0");
  const minutes = now.getMinutes().toString().padStart(2, "0");
  const seconds = now.getSeconds().toString().padStart(2, "0");

  const currentTime = `${hours}:${minutes}:${seconds}`;
  document.getElementById("clock").innerText = "현재 접속 시간: " + currentTime;
}

updateClock(); // 페이지 로딩 시 즉시 실행
setInterval(updateClock, 1000); // 1초마다 반복 실행
