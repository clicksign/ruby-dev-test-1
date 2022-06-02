# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js"
