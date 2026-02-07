const downloadsList = document.querySelector("#downloads-list");
const fileCount = document.querySelector("#file-count");
const healthStatus = document.querySelector("#health-status");

function formatBytes(size) {
  if (!Number.isFinite(size)) {
    return "Unknown";
  }

  const units = ["B", "KB", "MB", "GB", "TB"];
  let value = size;
  let unitIndex = 0;
  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex += 1;
  }
  return `${value.toFixed(value >= 10 || unitIndex === 0 ? 0 : 1)} ${units[unitIndex]}`;
}

function renderFiles(files) {
  if (!downloadsList) {
    return;
  }

  if (!Array.isArray(files) || files.length === 0) {
    downloadsList.innerHTML = "";
    const empty = document.createElement("p");
    empty.className = "empty";
    empty.textContent = "No files found yet. Add artifacts to the downloads/ folder.";
    downloadsList.append(empty);
    if (fileCount) {
      fileCount.textContent = "0";
    }
    return;
  }

  downloadsList.innerHTML = "";
  if (fileCount) {
    fileCount.textContent = String(files.length);
  }

  for (const file of files) {
    const card = document.createElement("article");
    card.className = "file-card";

    const name = document.createElement("p");
    name.className = "file-name";
    name.textContent = file.name;

    const details = document.createElement("p");
    details.className = "file-meta";
    details.textContent = `${formatBytes(file.size)} | SHA256 ${String(file.sha256).slice(0, 12)}...`;

    const actions = document.createElement("div");
    actions.className = "file-actions";

    const download = document.createElement("a");
    download.className = "button button-primary";
    download.href = file.url;
    download.textContent = "Download";

    const copy = document.createElement("button");
    copy.className = "button button-secondary";
    copy.type = "button";
    copy.textContent = "Copy SHA256";
    copy.addEventListener("click", async () => {
      try {
        await navigator.clipboard.writeText(file.sha256);
        copy.textContent = "Copied";
        setTimeout(() => {
          copy.textContent = "Copy SHA256";
        }, 1300);
      } catch {
        copy.textContent = "Copy failed";
      }
    });

    actions.append(download, copy);
    card.append(name, details, actions);
    downloadsList.append(card);
  }
}

async function loadFiles() {
  try {
    const response = await fetch("/api/files", {
      headers: { accept: "application/json" },
      cache: "no-store"
    });

    if (!response.ok) {
      throw new Error(`Request failed: ${response.status}`);
    }

    const payload = await response.json();
    renderFiles(payload.files ?? []);
  } catch {
    if (downloadsList) {
      downloadsList.innerHTML = "";
      const errorText = document.createElement("p");
      errorText.className = "empty";
      errorText.textContent = "Could not load file list. Check the server logs and refresh.";
      downloadsList.append(errorText);
    }
    if (fileCount) {
      fileCount.textContent = "-";
    }
  }
}

async function loadHealth() {
  if (!healthStatus) {
    return;
  }

  try {
    const response = await fetch("/healthz", { headers: { accept: "application/json" }, cache: "no-store" });
    if (!response.ok) {
      throw new Error(`Health failed: ${response.status}`);
    }
    const body = await response.json();
    healthStatus.textContent = body.ok ? "Healthy" : "Unknown";
  } catch {
    healthStatus.textContent = "Unavailable";
  }
}

await Promise.all([loadHealth(), loadFiles()]);
