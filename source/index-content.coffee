tag = document.createElement "script"
tag.src = chrome.extension.getURL "inject.js"
document.head.appendChild tag
