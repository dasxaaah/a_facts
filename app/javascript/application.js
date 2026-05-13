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

import "trix"
import "@rails/actiontext"
