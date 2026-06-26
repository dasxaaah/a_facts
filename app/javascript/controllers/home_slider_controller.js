import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['track']

  previous() {
    this.scroll(-1)
  }

  next() {
    this.scroll(1)
  }

  scroll(direction) {
    const card = this.trackTarget.querySelector('.home_slider_card')
    if (!card) return

    const gap = parseFloat(getComputedStyle(this.trackTarget).gap) || 0
    const distance = card.getBoundingClientRect().width + gap

    this.trackTarget.scrollBy({
      left: direction * distance,
      behavior: 'smooth',
    })
  }
}
