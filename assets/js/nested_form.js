const link = document.getElementById('add_videos');

if(!link) return;

link.addEventListener('click', (event) => {
  event.preventDefault();

  const time = new Date().getTime();
  const template = link.dataset.template;

  const templateWithTime = template.replace(/\[0\]/g, `[${time}]`);
  const uniqueTemplate = templateWithTime.replace(/_0_/g, `_${time}_`)

  const videoContainer = document.getElementById('videos-container');

  videoContainer.insertAdjacentHTML('beforeend', uniqueTemplate);
});
