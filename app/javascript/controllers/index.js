document.addEventListener("DOMContentLoaded", function() {
  const timeInput = document.getElementById("time_input");

  if (timeInput) {
    timeInput.addEventListener("blur", function() {
      let value = timeInput.value;

      // 4桁の数字であることを確認
      if (value.length === 4 && /^[0-9]{4}$/.test(value)) {
        // 時間と分に分割
        let hours = value.substring(0, 2);
        let minutes = value.substring(2);

        // 新しい値を設定
        timeInput.value = `${hours}:${minutes}`;
      }
    });
  }
});

