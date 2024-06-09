document.addEventListener('turbo:load', function () {
  let textareas = document.querySelectorAll('.auto-resize-textarea');
  textareas.forEach(function(textarea) {
    let clientHeight = textarea.clientHeight;
    textarea.addEventListener('input', function () {
      textarea.style.height = clientHeight + 'px';
      let scrollHeight = textarea.scrollHeight;
      textarea.style.height = scrollHeight + 'px';
    });

    // 初期化
    textarea.style.height = clientHeight + 'px';
    let scrollHeight = textarea.scrollHeight;
    textarea.style.height = scrollHeight + 'px';
  });
});
