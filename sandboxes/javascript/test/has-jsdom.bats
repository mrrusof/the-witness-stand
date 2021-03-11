#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<"EOF"
const jsdom = require('jsdom');
const { JSDOM } = jsdom;

const dom = new JSDOM(`
<!DOCKTYPE html>
<body>
<h1>You Got The Title</h1>
</body>
`);

console.log(dom.window.document.querySelector('h1').textContent);
EOF
)

expected_stdout=$(cat <<"EOF"
You Got The Title
EOF
)
