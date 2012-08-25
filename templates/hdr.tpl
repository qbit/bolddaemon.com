<!DOCTYPE html>
<html>
<head>
	<title>${title} - ${subtitle}</title>
	<script src="/jquery.min.js" type="text/javascript"></script>
	<script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<link type="text/css" rel="stylesheet" href="/bootstrap/css/bootstrap.min.css"/>
	<script>
		function Fish( o ) {
			var self = this;
			o = o || {};
			this.tank = {};
			this.tank.canvas = document.getElementById( o.canvas || 'bg');
			this.tank.width = document.width || document.documentElement.scrollWidth;
			this.tank.height =  document.height || document.documentElement.scrollHeight;

			setTimeout( function() {
				self.tank.width = document.width || document.documentElement.scrollWidth;
				self.tank.height =  document.height || document.documentElement.scrollHeight;
			}, 500 );

			this.tank.width = this.tank.width - 10;
			this.tank.height = this.tank.height - 10;

			this.tank.canvas.width = this.tank.width;
			this.tank.canvas.height = this.tank.height;

			this.tank.canvas.style.width = this.tank.width + 'px';
			this.tank.canvas.style.height = this.tank.height + 'px';

			this.tank.canvas.style.position = 'absolute';
			this.tank.canvas.style.top = '0px';
			this.tank.canvas.style.left = '0px';

			this.ctx = this.tank.canvas.getContext("2d");

			this.imgR = new Image();
			this.imgR.src = o.right_image;

			this.imgL = new Image();
			this.imgL.src = o.left_image;

			this.imgX = o.x || 0;
			this.imgY = o.y || 0;

			this.revX = false;
			this.revY = false;

			this.flip = false;

			this.xInc = o.x_inc || 1;
			this.yInc = o.y_inc || Math.random();

			this.randY = o.random_y || true;

			this.img = this.imgR;

			this.draw = function() {
				if (self.imgX + 50 < self.tank.canvas.width && ! self.revX) {
					self.imgX += self.xInc;
				} else {
					self.revX = true;
				}
				if (self.imgY + 51 < self.tank.canvas.height && !self.revY) {
					self.imgY += self.yInc;
				} else {
					self.revY = true;
				}

				if (self.revY && self.imgY > 0) {
					self.imgY -= self.yInc;
				} else {
					self.revY = false;
				}
				if (self.revX && self.imgX > 0) {
					self.imgX -= self.xInc;
				} else {
					self.revX = false;
					self.flip = true;
				}

				self.ctx.clearRect(0, 0, self.tank.canvas.width, self.tank.canvas.height);

				if (self.revX && self.flip) {
					self.yInc = Math.random();
					self.xInc = Math.random();
					self.flip = false;
				}

				self.img = ( self.flip ? self.imgR : self.imgL );
				
				self.ctx.drawImage(self.img, self.imgX, self.imgY, 50, 51);
			}

			setInterval( this.draw, o.interval || 10 );

			return this;
		}
	</script>
</head>
<!-- <body onload="load();"> -->
	<body onload="new Fish( {right_image: '/pbg.png', left_image: '/pbgl.png' } );">
		<div class="container">
			<div class="navbar navbar-fixed-top">
				<div class="navbar-inner">
					<a class="brand" href="#">BD</a>

