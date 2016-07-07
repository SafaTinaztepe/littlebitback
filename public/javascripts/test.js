var page = require('webpage').create();
	page.viewportSize = { width: 1024, height: 768 };
	page.open('http://www.google.com', function() {
	page.render('./public/uploads/sourceimages/test.png');
	phantom.exit();
	});