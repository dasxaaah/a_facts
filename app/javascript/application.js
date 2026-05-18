// import '@hotwired/turbo-rails'
// import { Application } from '@hotwired/stimulus'
// import { definitionsFromContext } from '@hotwired/stimulus-loading'
// import '@hotwired/turbo-rails'

import '@hotwired/turbo-rails'
import 'controllers'

import 'trix'
import '@rails/actiontext'
// const application = Application.start()
// const context = require.context('./controllers', true, /\.js$/)
// application.load(definitionsFromContext(context))
document.addEventListener('turbo:load', () => {
  const input = document.getElementById('community_post_image_input')
  const preview = document.getElementById('community_image_preview')

  if (!input || !preview) return

  input.addEventListener('change', () => {
    const file = input.files[0]
    preview.innerHTML = ''

    if (!file) return

    const image = document.createElement('img')
    image.src = URL.createObjectURL(file)
    image.className = 'community_ask_preview_image'

    preview.appendChild(image)
  })
})

document.addEventListener('turbo:load', () => {
  const modal = document.querySelector('[data-community-modal]')
  const openButtons = document.querySelectorAll('[data-open-community-modal]')
  const closeButtons = document.querySelectorAll('[data-close-community-modal]')
  const input = document.getElementById('community_post_image_input')
  const preview = document.getElementById('community_image_preview')

  if (!modal) return

  openButtons.forEach((button) => {
    button.addEventListener('click', () => {
      modal.classList.add('community_modal_open')
      document.body.classList.add('modal_open')
    })
  })

  closeButtons.forEach((button) => {
    button.addEventListener('click', () => {
      modal.classList.remove('community_modal_open')
      document.body.classList.remove('modal_open')

      if (preview) preview.innerHTML = ''
      if (input) input.value = ''
    })
  })

  if (input && preview) {
    input.addEventListener('change', () => {
      const file = input.files[0]
      preview.innerHTML = ''

      if (!file) return

      const image = document.createElement('img')
      image.src = URL.createObjectURL(file)
      image.className = 'community_ask_preview_image'

      preview.appendChild(image)
    })
  }
})

document.addEventListener('turbo:load', () => {
  const modal = document.querySelector('[data-profile-work-modal]')
  const openButtons = document.querySelectorAll('[data-open-profile-work-modal]')
  const closeButtons = document.querySelectorAll('[data-close-profile-work-modal]')
  const profilePage = document.querySelector('.profile_page')
  const form = document.querySelector('[data-profile-work-form]')
  const start = document.querySelector('[data-profile-work-start]')
  const editor = document.querySelector('[data-profile-work-editor]')
  const actions = document.querySelector('[data-profile-work-actions]')
  const publishedPanel = document.querySelector('[data-profile-published-panel]')
  const draftsPanel = document.querySelector('[data-profile-drafts-panel]')
  const draftsButton = document.querySelector('[data-profile-show-drafts]')
  const typeButtons = document.querySelectorAll('[data-profile-work-type]')
  const photoInput = document.querySelector('[data-profile-work-photo-input]')
  const videoInput = document.querySelector('[data-profile-work-video-input]')
  const preview = document.querySelector('[data-profile-work-preview]')
  const titleInput = document.querySelector('[data-profile-work-title-input]')
  const statusInput = document.querySelector('[data-profile-work-status-input]')
  const kindInput = document.querySelector('[data-profile-work-kind-input]')
  const description = document.querySelector('[data-profile-work-description]')
  const colorInput = document.querySelector('[data-profile-work-color-input]')
  const colorCode = document.querySelector('[data-profile-work-color-code]')
  const lineHeightInput = document.querySelector('[data-profile-work-line-height]')
  const lineHeightValue = document.querySelector('[data-profile-work-line-height-value]')
  const publishButton = document.querySelector('[data-profile-work-publish]')
  const saveDraftButton = document.querySelector('[data-profile-work-save-draft]')

  if (!modal) return

  let currentWorkType = 'text'
  let currentWorkUrl = ''

  const resetProjectModal = () => {
    start?.classList.remove('profile_work_start_hidden')
    editor?.classList.remove('profile_work_editor_visible')
    actions?.classList.remove('profile_work_modal_actions_visible')
    currentWorkType = 'text'
    currentWorkUrl = ''

    if (preview) {
      preview.innerHTML = '<p class="profile_work_preview_empty">Выберите файл или начните с текста</p>'
      preview.style.backgroundColor = '#000000'
    }

    if (photoInput) photoInput.value = ''
    if (videoInput) videoInput.value = ''
    if (photoInput) photoInput.disabled = false
    if (videoInput) videoInput.disabled = false
    if (titleInput) titleInput.value = ''
    if (statusInput) statusInput.value = 'published'
    if (kindInput) kindInput.value = 'text'
    if (description) {
      description.value = ''
      description.style.lineHeight = '1.4'
    }
    if (colorInput) colorInput.value = '#000000'
    if (colorCode) colorCode.textContent = '#000000'
    if (lineHeightInput) lineHeightInput.value = '1.4'
    if (lineHeightValue) lineHeightValue.textContent = '1.4'
  }

  const showEditor = () => {
    start?.classList.add('profile_work_start_hidden')
    editor?.classList.add('profile_work_editor_visible')
    actions?.classList.add('profile_work_modal_actions_visible')
  }

  const showFilePreview = (file) => {
    if (!file || !preview) return

    const fileUrl = URL.createObjectURL(file)
    currentWorkUrl = fileUrl
    preview.innerHTML = ''

    if (file.type.startsWith('video/')) {
      currentWorkType = 'video'
      if (kindInput) kindInput.value = 'video'
      if (photoInput) photoInput.disabled = true
      if (videoInput) videoInput.disabled = false
      const video = document.createElement('video')
      video.src = fileUrl
      video.controls = true
      preview.appendChild(video)
    } else {
      currentWorkType = 'photo'
      if (kindInput) kindInput.value = 'photo'
      if (photoInput) photoInput.disabled = false
      if (videoInput) videoInput.disabled = true
      const image = document.createElement('img')
      image.src = fileUrl
      image.alt = 'Выбранный файл'
      preview.appendChild(image)
    }

    showEditor()
  }

  const closeProjectModal = () => {
    modal.classList.remove('profile_work_modal_open')
    if (profilePage) profilePage.classList.remove('profile_page_modal_open')
    resetProjectModal()
  }

  const showDraftsPanel = () => {
    publishedPanel?.classList.add('profile_published_grid_hidden')
    draftsPanel?.classList.add('profile_drafts_folder_visible')
    draftsButton?.classList.add('profile_drafts_button_active')
  }

  const showPublishedPanel = () => {
    publishedPanel?.classList.remove('profile_published_grid_hidden')
    draftsPanel?.classList.remove('profile_drafts_folder_visible')
    draftsButton?.classList.remove('profile_drafts_button_active')
  }

  openButtons.forEach((button) => {
    button.addEventListener('click', () => {
      resetProjectModal()
      modal.classList.add('profile_work_modal_open')
      if (profilePage) profilePage.classList.add('profile_page_modal_open')
    })
  })

  closeButtons.forEach((button) => {
    button.addEventListener('click', () => {
      modal.classList.remove('profile_work_modal_open')
      if (profilePage) profilePage.classList.remove('profile_page_modal_open')
      resetProjectModal()
    })
  })

  typeButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const type = button.dataset.profileWorkType

      if (type === 'photo') {
        if (photoInput) photoInput.disabled = false
        if (videoInput) videoInput.disabled = true
        photoInput?.click()
      } else if (type === 'video') {
        if (photoInput) photoInput.disabled = true
        if (videoInput) videoInput.disabled = false
        videoInput?.click()
      } else {
        if (preview) {
          preview.innerHTML = '<p class="profile_work_preview_text">Текст</p>'
        }
        currentWorkType = 'text'
        currentWorkUrl = ''
        if (kindInput) kindInput.value = 'text'
        if (photoInput) photoInput.disabled = true
        if (videoInput) videoInput.disabled = true
        showEditor()
      }
    })
  })

  photoInput?.addEventListener('change', () => {
    showFilePreview(photoInput.files[0])
  })

  videoInput?.addEventListener('change', () => {
    showFilePreview(videoInput.files[0])
  })

  colorInput?.addEventListener('input', () => {
    if (preview) preview.style.backgroundColor = colorInput.value
    if (colorCode) colorCode.textContent = colorInput.value
  })

  lineHeightInput?.addEventListener('input', () => {
    if (description) description.style.lineHeight = lineHeightInput.value
    if (lineHeightValue) lineHeightValue.textContent = lineHeightInput.value
  })

  publishButton?.addEventListener('click', () => {
    if (!form) return

    if (titleInput && !titleInput.value.trim()) titleInput.value = 'Новый проект'
    if (statusInput) statusInput.value = 'published'
    showPublishedPanel()
    form.requestSubmit()
  })

  saveDraftButton?.addEventListener('click', () => {
    if (!form) return

    if (titleInput && !titleInput.value.trim()) titleInput.value = 'Новый проект'
    if (statusInput) statusInput.value = 'draft'
    showDraftsPanel()
    form.requestSubmit()
  })

  draftsButton?.addEventListener('click', () => {
    showDraftsPanel()
  })
})

import "trix"
import "@rails/actiontext"
