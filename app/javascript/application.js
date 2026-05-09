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
