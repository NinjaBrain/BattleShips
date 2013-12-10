package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Emil Söderberg
	 */
	public class Tile extends Sprite
	{
		//här är 3 olika bilder som objektet kan ha, default är WaterTile (normal)
		[Embed(source="../lib/WaterTile.png")]
		private var tile:Class;
		private var watertile:Bitmap = new tile;
		
		[Embed(source = "../lib/WaterTile Splash.png")]
		private var tile2:Class;
		private var splashtile:Bitmap = new tile2;
		
		[Embed(source = "../lib/WaterTileExplosion.png")]
		private var tile3:Class;
		private var explosiontile:Bitmap = new tile3;
		
		//en boolean avgör om tilen är ett skepp eller ej
		private var isShip:Boolean = false;
		
		//glowfilter använder jag för att ge en border till tilen
		private var glowfilter:GlowFilter = new GlowFilter(0x000000, 1, 6, 6, 20, 1);
		public function Tile() 
		{
			//här säger jag att objektet ska vara en bild, och att den ska vara WaterTile
			this.graphics.beginBitmapFill(watertile.bitmapData, new Matrix, false);
			this.graphics.drawRect(0, 0, 32, 32);
			this.graphics.endFill();
			this.filters = [glowfilter];
			this.addEventListener(MouseEvent.CLICK, changeTo);
		}
		
		public function setAsShip():void 
		{
			//när denna funktion blir kallad blir objektet till ett skepp
			isShip = true;
		}
		
		private function changeTo(e:MouseEvent):void 
		{
			//denna funktion blir kallad när man klickar på tilen, om tilen är ett skepp ska den anropa changetoexplo, om den inte är ett
			//skepp ska den kalla på changetosplash
			if (isShip == true) 
			{
				changeToExplo();
			}
			
			else 
			{
				changeToSplash();
			}
		}
		
		public function changeToSplash():void 
		{
			//här resettar vi grafiken och målar om tilen som en splashtile
			this.graphics.clear();
			this.graphics.beginBitmapFill(splashtile.bitmapData, new Matrix, false);
			this.graphics.drawRect(0,0,32,32);
			this.graphics.endFill();
		}
		
		public function changeToExplo():void 
		{
			//här resettar vi grafiken och målar om tilen som en explotile
			this.graphics.clear();
			this.graphics.beginBitmapFill(explosiontile.bitmapData, new Matrix, false);
			this.graphics.drawRect(0,0,32,32);
			this.graphics.endFill();
		}
		
	}

}