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
  const menu = document.querySelector('.menu')
  const mobileMenuToggle = document.querySelector('[data-mobile-menu-toggle]')

  if (!menu || !mobileMenuToggle) return

  mobileMenuToggle.addEventListener('click', (event) => {
    event.stopPropagation()
    menu.classList.toggle('menu_mobile_open')
  })

  document.addEventListener('click', (event) => {
    if (!menu.contains(event.target)) {
      menu.classList.remove('menu_mobile_open')
    }
  })

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape') {
      menu.classList.remove('menu_mobile_open')
    }
  })
})

document.addEventListener('turbo:load', () => {
  const tutorialSidebar = document.querySelector('.tutorial_sidebar')
  const tutorialSidebarToggle = document.querySelector('[data-tutorial-sidebar-toggle]')
  const tutorialSidebarLinks = document.querySelectorAll('.tutorial_sidebar_link')

  if (!tutorialSidebar || !tutorialSidebarToggle) return

  tutorialSidebarToggle.addEventListener('click', () => {
    tutorialSidebar.classList.toggle('tutorial_sidebar_open')
  })

  tutorialSidebarLinks.forEach((link) => {
    link.addEventListener('click', (event) => {
      const moduleId = link.dataset.tutorialModuleId

      if (moduleId) {
        event.preventDefault()

        document.querySelectorAll('[data-tutorial-module]').forEach((module) => {
          module.hidden = module.id !== moduleId
        })

        tutorialSidebarLinks.forEach((sidebarLink) => {
          sidebarLink.classList.toggle(
            'tutorial_sidebar_link_active',
            sidebarLink === link
          )
        })

        history.replaceState(null, '', `#${moduleId}`)
      }

      tutorialSidebar.classList.remove('tutorial_sidebar_open')
    })
  })

  const currentModuleId = window.location.hash.slice(1)
  const currentLink = currentModuleId
    ? document.querySelector(`[data-tutorial-module-link][data-tutorial-module-id="${currentModuleId}"]`)
    : null

  currentLink?.click()
})

document.addEventListener('turbo:load', () => {
  const articleFilters = document.querySelectorAll('[data-article-filter]')

  if (!articleFilters.length) return

  const closeArticleFilters = (exceptFilter = null) => {
    articleFilters.forEach((filter) => {
      if (filter !== exceptFilter) filter.classList.remove('articles_filter_dropdown_open')
    })
  }

  articleFilters.forEach((filter) => {
    const toggle = filter.querySelector('[data-article-filter-toggle]')

    toggle?.addEventListener('click', (event) => {
      event.stopPropagation()
      const isOpen = filter.classList.contains('articles_filter_dropdown_open')

      closeArticleFilters(filter)
      filter.classList.toggle('articles_filter_dropdown_open', !isOpen)
    })

    filter.addEventListener('click', (event) => {
      event.stopPropagation()
    })
  })

  document.addEventListener('click', () => {
    closeArticleFilters()
  })

  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape') closeArticleFilters()
  })
})

document.addEventListener('turbo:load', () => {
  const tagFilter = document.querySelector('[data-community-tag-filter]')
  const tagButtons = document.querySelectorAll('[data-community-filter-tag]')
  const postCards = document.querySelectorAll('[data-community-post-card]')

  if (!tagFilter || !tagButtons.length || !postCards.length) return

  const setActiveTag = (activeTag) => {
    postCards.forEach((card) => {
      const tags = (card.dataset.communityPostTags || '').split(/\s+/)
      card.hidden = activeTag ? !tags.includes(activeTag) : false
    })

    tagButtons.forEach((button) => {
      button.classList.toggle(
        'community_popular_tag_active',
        button.dataset.communityFilterTag === activeTag
      )
    })
  }

  tagButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const tag = button.dataset.communityFilterTag
      const isActive = button.classList.contains('community_popular_tag_active')

      setActiveTag(isActive ? null : tag)
    })
  })
})

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
  const openImagePickerButtons = document.querySelectorAll('[data-community-open-image-picker]')
  const openFilePickerButtons = document.querySelectorAll('[data-community-open-file-picker]')
  const fileInput = document.querySelector('[data-community-file-input]')
  const preview = document.getElementById('community_image_preview')

  if (!modal) return

  const openCommunityModal = () => {
    modal.classList.add('community_modal_open')
    document.body.classList.add('modal_open')
  }

  openButtons.forEach((button) => {
    button.addEventListener('click', () => {
      openCommunityModal()
    })
  })

  openImagePickerButtons.forEach((button) => {
    button.addEventListener('click', () => {
      input?.click()
    })
  })

  openFilePickerButtons.forEach((button) => {
    button.addEventListener('click', () => {
      fileInput?.click()
    })
  })

  fileInput?.addEventListener('change', () => {
    if (fileInput.files[0]) openCommunityModal()
  })

  closeButtons.forEach((button) => {
    button.addEventListener('click', () => {
      modal.classList.remove('community_modal_open')
      document.body.classList.remove('modal_open')

      if (preview) preview.innerHTML = ''
      if (input) input.value = ''
      if (fileInput) fileInput.value = ''
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
      openCommunityModal()
    })
  }
})

document.addEventListener('turbo:load', () => {
  const postsContainer = document.querySelector('[data-community-posts]')
  const loadMoreButton = document.querySelector('[data-community-load-more]')

  loadMoreButton?.addEventListener('click', async (event) => {
    event.preventDefault()

    const nextUrl = loadMoreButton.getAttribute('href')
    if (!nextUrl || !postsContainer) return

    loadMoreButton.textContent = 'Загрузка...'
    loadMoreButton.setAttribute('aria-busy', 'true')

    try {
      const response = await fetch(nextUrl, {
        headers: { Accept: 'text/html' }
      })
      const html = await response.text()
      const doc = new DOMParser().parseFromString(html, 'text/html')
      const nextPosts = doc.querySelectorAll('[data-community-posts] .community_post_card')
      const nextButton = doc.querySelector('[data-community-load-more]')

      nextPosts.forEach((post) => postsContainer.appendChild(post))

      if (nextButton) {
        loadMoreButton.setAttribute('href', nextButton.getAttribute('href'))
        loadMoreButton.textContent = 'Загрузить ещё'
        loadMoreButton.removeAttribute('aria-busy')
      } else {
        loadMoreButton.closest('.community_load_more')?.remove()
      }
    } catch {
      loadMoreButton.textContent = 'Попробовать ещё раз'
      loadMoreButton.removeAttribute('aria-busy')
    }
  })
})

document.addEventListener('turbo:load', () => {
  const meetupModal = document.querySelector('[data-meetup-modal]')
  const openMeetupButtons = document.querySelectorAll('[data-open-meetup-modal]')
  const closeMeetupButtons = document.querySelectorAll('[data-close-meetup-modal]')

  if (!meetupModal) return

  const openMeetupModal = () => {
    meetupModal.classList.add('meetup_confirm_modal_open')
    document.body.classList.add('modal_open')
  }

  const closeMeetupModal = () => {
    meetupModal.classList.remove('meetup_confirm_modal_open')
    document.body.classList.remove('modal_open')
  }

  openMeetupButtons.forEach((button) => {
    button.addEventListener('click', openMeetupModal)
  })

  closeMeetupButtons.forEach((button) => {
    button.addEventListener('click', closeMeetupModal)
  })
})

document.addEventListener('turbo:load', () => {
  const galleryModal = document.querySelector('[data-contest-gallery-modal]')
  const galleryTitle = document.querySelector('[data-contest-gallery-modal-title]')
  const galleryDescription = document.querySelector('[data-contest-gallery-modal-description]')
  const galleryGrid = document.querySelector('[data-contest-gallery-modal-grid]')
  const openGalleryButtons = document.querySelectorAll('[data-open-contest-gallery]')
  const closeGalleryButtons = document.querySelectorAll('[data-close-contest-gallery]')

  if (!galleryModal || !galleryGrid) return

  const closeGalleryModal = () => {
    galleryModal.classList.remove('contest_gallery_modal_open')
    document.body.classList.remove('modal_open')
  }

  openGalleryButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const gallery = button.closest('[data-contest-gallery]')
      if (!gallery) return

      const items = JSON.parse(gallery.dataset.contestGalleryItems || '[]')

      if (galleryTitle) galleryTitle.textContent = gallery.dataset.contestGalleryTitle || ''
      if (galleryDescription) galleryDescription.textContent = gallery.dataset.contestGalleryDescription || ''

      galleryGrid.innerHTML = ''
      items.forEach((item) => {
        const card = document.createElement('div')
        card.className = 'contest_gallery_modal_card'

        const img = document.createElement('img')
        img.src = item.image
        img.alt = gallery.dataset.contestGalleryTitle || ''
        img.className = 'contest_gallery_modal_image'

        const imageWrapper = document.createElement('div')
        imageWrapper.className = 'contest_gallery_modal_image_wrapper'
        imageWrapper.appendChild(img)

        const author = document.createElement('div')
        author.className = 'contest_gallery_modal_author'

        const avatar = document.createElement('img')
        avatar.src = item.avatar
        avatar.alt = ''
        avatar.className = 'community_post_avatar'

        const name = document.createElement('span')
        name.className = 'community_post_author'
        name.textContent = item.author

        author.appendChild(avatar)
        author.appendChild(name)

        let ownerBadge = null
        if (item.isCurrentUser) {
          ownerBadge = document.createElement('span')
          ownerBadge.className = 'profile_board_item_badge profile_board_item_badge_article contest_gallery_modal_owner_badge'
          ownerBadge.textContent = 'Ваш проект'
        }

        const likeButton = document.createElement('button')
        likeButton.className = 'community_post_like_button contest_gallery_modal_like'
        likeButton.type = 'button'
        likeButton.setAttribute('aria-label', 'Поставить лайк')
        likeButton.innerHTML = `
          <svg class="community_post_stat_icon community_post_like_icon" viewBox="0 0 30 30" aria-hidden="true" focusable="false">
            <path class="community_post_like_shape" d="M21.7005 25H7.5C6.11929 25 5 23.8807 5 22.5V12.5H9.91204C10.7479 12.5 11.5285 12.0822 11.9922 11.3868L15.1368 6.66987C15.8322 5.62663 17.0031 5 18.2569 5H18.5244C19.2968 5 19.8844 5.69358 19.7574 6.4555L18.75 12.5H23.2005C24.7781 12.5 25.9613 13.9433 25.6519 15.4903L24.1519 22.9903C23.9182 24.1589 22.8922 25 21.7005 25Z" />
            <path class="community_post_like_line" d="M10 12.5V25" />
          </svg>
          <span class="community_post_like_count">${item.likes || 0}</span>
        `
        likeButton.addEventListener('click', () => {
          const count = likeButton.querySelector('.community_post_like_count')
          const isLiked = likeButton.classList.toggle('community_post_like_button_active')
          const currentCount = Number.parseInt(count?.textContent || '0', 10)

          if (count) count.textContent = Math.max(0, currentCount + (isLiked ? 1 : -1))
          likeButton.setAttribute('aria-label', isLiked ? 'Убрать лайк' : 'Поставить лайк')
        })

        card.appendChild(author)
        if (ownerBadge) imageWrapper.appendChild(ownerBadge)
        card.appendChild(imageWrapper)
        card.appendChild(likeButton)
        galleryGrid.appendChild(card)
      })

      galleryModal.classList.add('contest_gallery_modal_open')
      document.body.classList.add('modal_open')
    })
  })

  closeGalleryButtons.forEach((button) => {
    button.addEventListener('click', closeGalleryModal)
  })
})

document.addEventListener('turbo:load', () => {
  const uploadButtons = document.querySelectorAll('[data-contest-upload-button]')

  uploadButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const slug = button.dataset.contestUploadButton
      const contestCard = button.closest(
        '.community_contest_card, .community_contest_card_main'
      )
      const input =
        contestCard?.querySelector(`[data-contest-submission-input="${slug}"]`) ||
        document.querySelector(`[data-contest-submission-input="${slug}"]`)

      if (!input) return

      input.value = ''
      input.click()
    })
  })

  document.querySelectorAll('[data-contest-submission-input]').forEach((input) => {
    input.addEventListener('change', () => {
      if (!input.files[0]) return

      const form = input.closest('form')

      if (form?.requestSubmit) {
        form.requestSubmit()
      } else {
        form?.submit()
      }
    })
  })
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
  const gridTitle = document.querySelector('[data-profile-grid-title]')
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
  const boardView = document.querySelector('[data-profile-board-view]')
  const openBoardButtons = document.querySelectorAll('[data-open-profile-board]')
  const closeBoardButton = document.querySelector('[data-close-profile-board]')
  const boardTitle = document.querySelector('[data-profile-board-view-title]')
  const boardCount = document.querySelector('[data-profile-board-count]')
  const boardFilter = document.querySelector('[data-profile-board-filter]')
  const boardItems = document.querySelectorAll('[data-profile-board-item]')
  const settingsEditButtons = document.querySelectorAll('[data-profile-settings-edit]')

  const updateBoardCount = () => {
    if (!boardCount) return

    const visibleItems = Array.from(boardItems).filter((item) => !item.hidden)
    boardCount.textContent = visibleItems.length
  }

  const applyBoardFilter = () => {
    const filter = boardFilter?.value || 'all'

    boardItems.forEach((item) => {
      item.hidden = filter !== 'all' && item.dataset.profileBoardType !== filter
    })

    updateBoardCount()
  }

  openBoardButtons.forEach((button) => {
    button.addEventListener('click', () => {
      if (boardTitle) boardTitle.textContent = button.dataset.profileBoardName || 'Доска'
      if (boardFilter) boardFilter.value = 'all'
      boardItems.forEach((item) => {
        item.hidden = false
      })
      updateBoardCount()
      boardView?.classList.add('profile_board_view_open')
      profilePage?.classList.add('profile_page_modal_open')
    })
  })

  closeBoardButton?.addEventListener('click', () => {
    boardView?.classList.remove('profile_board_view_open')
    profilePage?.classList.remove('profile_page_modal_open')
  })

  boardFilter?.addEventListener('change', applyBoardFilter)

  settingsEditButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const form = button.closest('[data-profile-settings-form]')
      const row = button.closest('.profile_settings_form_row')
      if (!form) return

      const isEditing = row?.classList.contains('profile_settings_form_row_editing')
      const inputs = row?.querySelectorAll('[data-profile-settings-input]') || []
      const passwordPreview = row?.querySelector('[data-profile-settings-password-preview]')
      const passwordInputs = row?.querySelector('[data-profile-settings-password-inputs]')

      if (isEditing) {
        form.requestSubmit()
        return
      }

      document.querySelectorAll('.profile_settings_form_row_editing').forEach((editingRow) => {
        editingRow.classList.remove('profile_settings_form_row_editing')
      })

      row?.classList.add('profile_settings_form_row_editing')
      button.setAttribute('aria-label', 'Сохранить')
      if (passwordPreview) passwordPreview.hidden = true
      if (passwordInputs) passwordInputs.classList.add('profile_settings_password_inputs_visible')

      inputs.forEach((input) => {
        input.removeAttribute('readonly')
        input.disabled = false
      })

      inputs[0]?.focus()
      inputs[0]?.select?.()
    })
  })

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
    if (gridTitle) gridTitle.textContent = 'Черновики'
  }

  const showPublishedPanel = () => {
    publishedPanel?.classList.remove('profile_published_grid_hidden')
    draftsPanel?.classList.remove('profile_drafts_folder_visible')
    draftsButton?.classList.remove('profile_drafts_button_active')
    if (gridTitle) gridTitle.textContent = 'Работы'
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
