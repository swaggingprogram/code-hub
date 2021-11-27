function markdownCode() {
  const codeInput = document.getElementById('new-code');
  const codeMarkdown = document.getElementById('preview-form');
  if (codeInput == null || codeMarkdown == null) {
    return;
  }

  codeInput.addEventListener('input', () => {
    const HTML = `${codeInput.value}`;
    codeMarkdown.innerHTML = marked(HTML);
    const pre_code_nodes = document.querySelectorAll("pre code");  // ここがポイント
    for(let i = 0; i < pre_code_nodes.length; ++i){                // ここがポイント
      hljs.highlightBlock(pre_code_nodes[i]);                      // ここがポイント
    }
  });
};

window.addEventListener("load", markdownCode);