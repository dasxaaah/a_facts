import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'
import { definitionsFromContext } from '@hotwired/stimulus-loading'
import '@hotwired/turbo-rails'

const application = Application.start()
const context = require.context('./controllers', true, /\.js$/)
application.load(definitionsFromContext(context))
