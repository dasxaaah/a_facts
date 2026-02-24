console.log('ARTICLES JS LOADED')
document.addEventListener('turbo:load', () => {
  console.log('ARTICLES GRID JS LOADED')

  const grid = document.querySelector('#articles_grid')
  console.log('grid found?', !!grid)

  if (!grid) return

  const hole = document.createElement('div')
  hole.className = 'push_card push_card--w2'
  grid.prepend(hole)
})
