package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
		
	public class Main extends Sprite 
	{
		private var randomW:int = Math.random() * 10;
		private var randomH:int = Math.random() * 10;
		private var shipmiddledisplayX:int;
		private var shipmiddledisplayY:int;
		private var shipfrontW:int;
		private var shipfrontH:int;
		private var shipbackW:int; 
		private var shipbackH:int;
		private var shipfrontdisplayX:int;
		private var shipfrontdisplayY:int;
		private var shipbackdisplayX:int;
		private var shipbackdisplayY:int;
		private var map:Vector.<Vector.<Sprite>> = new Vector.<Vector.<Sprite>>();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//kallar på shiprotation och setupmap funktionerna
			shipRotation();
			setupMap();
		
			//lyssnaren kollar efter knapp ned tryckningar
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkRestart);
		}
		
		
		private function checkRestart(e:KeyboardEvent):void 
		{
			//funktionen kollar om knappen som är nere är spacebar, isåfall ska den kalla på restart funktionen
			if (e.keyCode == 32) 
			{
				restart();
			}
		}
		
		private function restart():void 
		{
			
			//här tas alla tiles bort
			for (var i:int = 0; i < map.length; i++) 
			{
				for each (var s:Sprite in map[i]) 
				{
					s.graphics.clear();
				}
			}
			
			//båtens kordnater resettas
			randomW = Math.random() * 10;
			randomH = Math.random() * 10;
			
			//båtens rotation resettas
			shipRotation();
			
			//mappen resettas
			setupMap();
			
		}
		
		private function shipRotation():void 
		{
			//funktionen bestämmer slumpvis om båten ska vara vertikal eller horizontelt placeras
			var verticalOrHorizontal:int = Math.random() * 2 + 1;
			if (verticalOrHorizontal == 1) 
			{
				//här blir den horizontell
				shipfrontH = randomH;
				shipfrontW = randomW - 1;
				shipbackH = randomH;
				shipbackW = randomW + 1;
				
				//det som str nedan använder jag för att få båtens exakta kordinater så jag kan trace rätt kordinater i output panel
				shipfrontdisplayX = shipfrontW + 1;
				shipfrontdisplayY = shipfrontH + 1;
				
				shipbackdisplayX = shipbackW + 1;
				shipbackdisplayY = shipbackH + 1;
				
				shipmiddledisplayX = randomW + 1;
				shipmiddledisplayY = randomH + 1;
				
				if (shipfrontdisplayX == 0 || shipbackdisplayX == 11) 
				{
					restart();
				}
			}
			
			if (verticalOrHorizontal == 2) 
			{
				//här blir den vertikal
				shipfrontH = randomH - 1;
				shipfrontW = randomW;
				shipbackH = randomH + 1;
				shipbackW = randomW;
				
				shipfrontdisplayX = shipfrontW + 1;
				shipfrontdisplayY = shipfrontH + 1;
				
				shipbackdisplayX = shipbackW + 1;
				shipbackdisplayY = shipbackH + 1;
				
				shipmiddledisplayX = randomW + 1;
				shipmiddledisplayY = randomH + 1;
				
				if (shipfrontdisplayY == 0 || shipbackdisplayY == 11) 
				{
					restart();
				}
			}
		}
		
		private function setupMap():void
		{
			//här genererar jag en vecktor med 10 sprites, och sedan fyller jag en vecktor med 10 sådana vecktorer.
			//varje ny rad placeras under den förra. detta skapar en map.
			for (var i:int = 0; i < 10; i++) 
			{
				//10 gånger skapar jag en ny vecktor
				var enRad:Vector.<Sprite> = new Vector.<Sprite>();
				
				for (var j:int = 0; j < 10; j++) 
				{	
					//varje vecktor får 10 tiles
					var s:Tile = new Tile();
					s.x = 100 + j * (s.width + 5);
					s.y = 100 + i * (s.height + 5);
					addChild(s);
					enRad.push(s);
					
					var heightpos:int = i;
					var widthpos:int = j;
					
					//här under har jag en trace i output panel för att kunna kolla så spelet funkar och fuska
					
					if (heightpos == randomH && widthpos == randomW) 
					{
						trace("Ship middle placed at x:" + shipmiddledisplayX + " and y:" + shipmiddledisplayY);
						s.setAsShip();
					}
					
					if (heightpos == shipfrontH && widthpos == shipfrontW) 
					{
						trace("Ship front placed at x:" + shipfrontdisplayX + " and y:" + shipfrontdisplayY);
						s.setAsShip();
					}
					
					if (heightpos == shipbackH && widthpos == shipbackW) 
					{
						trace("Ship back placed at x:" + shipbackdisplayX + " and y:" + shipbackdisplayY);
						s.setAsShip();
					}
					
				}
				//alla nya vecktorer läggs in i den första vecktorn
				map.push(enRad);
			}
		}
	}
	//KOMMENTARER
	//Nackdelar:
	//I koden tracear jag kordinaterna för skeppet. Att tracea belastar och fyller output panel med text mer och mer varje gång
	//vi restartar. Om ja gtar bort trace får spelet mycket bättre prestanda, men jag har kvar den för debuggning.
	//Det är också dåligt att jag behövde deklarera extra variabler för tracens skull.
	//en annan klumpig sak är hur jag har gjort bliderna. Om jag hade kunnat scalea ner bilderna hade jag inte behövt måla om ena hörnet 
	//(klicka på bilderna i lib)
	//En annan nackdel är kompabiliteten med extra skepp. Det krävs dubbel kod för att lägga ut fler. Detta kunde jag undvikit om jag skapat 
	//båt kordinaterna i Tile klassen så jag enkelt kan sätta ut jämförelse kordinater i main.
	//om jag hade ritat om scenen istället för att ta bort och rita om när jag restartar hade programmet blivit mer optimal.
}