package com.adams.cambook.views.components
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	import flashx.textLayout.formats.VerticalAlign;
	
	import mx.events.FlexEvent;
	import mx.events.SandboxMouseEvent;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.components.supportClasses.TextBase;
	import spark.events.DropDownEvent;
	import spark.primitives.Rect;
	import spark.primitives.supportClasses.FilledElement;
	
	/**
	 * The color when an icon is passive (rating off).
	 * TODO: Implement style change in styleChanged()
	 */
	[Style(name="passiveIconColor",type="Number",format="Color")]
	
	/**
	 * The color when an icon is active (rating on)
	 * TODO: Implement style change in styleChanged()
	 */
	[Style(name="activeIconColor",type="Number",format="Color")]
	
	/**
	 * The rating icon to show
	 * TODO: Implement style change in styleChanged()
	 */
	[Style(name="ratingIcon",type="ClassReference")]
	
	/**
	 *  Dispatched when the dropDown is dismissed
	 */
	[Event(name="close", type="spark.events.DropDownEvent")]
	
	/**
	 *  Dispatched when the user clicks the dropDown button
	 *  to display the dropDown.
	 */
	[Event(name="open", type="spark.events.DropDownEvent")]
	
	/**
	 *  Open State of the DropDown component
	 */
	[SkinState("open")]
	
	/**
	 * Over State of the DropDown component.
	 * When the mouse is over the open element
	 */
	[SkinState("over")]
	
	
	/**
	 * 
	 * A component for a PopUpRating.
	 * There is a placeholder that serves as a button and shows the current rating. 
	 * The current rating is reflected by a) a label and b) the amount the placeholder
	 * is filled with color.
	 * Once the placeholder is clicked, the ratings open as a popup. The rating
	 * can be adjusted by dragging the mouse over the ratings. While dragging
	 * the mouse, the ratings get filled with color and the placeholder is updated to
	 * reflect the new rating.
	 * MXML-Components that define the icons can be passed as styles. The components
	 * are the pushed down to the skin.
	 * You usually define the Icons in grey-scale. The Colorization is done by the
	 * component using the styles activeIconColor and passiveIconColor.
	 * 
	 * TODO:
	 * overwrite styleChanged() for runtime style updates
	 * Make the number of icons to use a public property. Leverage Update
	 * clean up code.
	 * check for leaks.
	 * optimize.
	 * 		
	 * @author andy andreas hulstkamp
	 * @version 0.1
	 * 
	 */
	public class RatingComponent extends SkinnableComponent
	{
		
		//--------------------------------------------------------------------------
		//
		//  Skin Parts
		//
		//--------------------------------------------------------------------------	
		
		/**
		 * 
		 */
		[SkinPart(required="true")]
		public var dropDown:Group;
		
		/**
		 *  A skin part that defines the anchor button.  
		 */
		[SkinPart(required="true")]
		public var openButton:Group;
		
		/**
		 *  A skin part that defines the group where the
		 *  active icons and the mask will be added.
		 */
		[SkinPart(required="true")]
		public var activeGroup:HGroup;
		
		/**
		 *  A skin part that defines the group where the
		 *  passive icons will be added.
		 */
		[SkinPart(required="true")]
		public var passiveGroup:HGroup;
		
		/**
		 *  A skin part for the label element
		 */
		[SkinPart(required="false")]
		public var labelText:TextBase;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor and Initialization
		//
		//--------------------------------------------------------------------------
		
	
		public function RatingComponent()
		{
			super();
			init();
		}
		
		/**
		 * Sets up the Component. Called from the constructor 
		 * 
		 */
		protected function init():void {
			//Set up the default converter function to get label text from rating
			ratingToLabel = this.defaultRatingToLabel;
			this.useHandCursor = true;
			this.buttonMode = true;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		public static const NUM_OF_RATING_ICONS:int = 5;
		
		//The mask that is used for the ratings
		public var ratingMask:FilledElement;
		
		//The mask that is used on the Rating Button
		private var buttonMask:FilledElement;
		
		//The range, calculated from the mask
		private var range:Number;
		
		//stores state for open of dropdown
		private var _isOpen:Boolean = false;
		
		//stores state for button over
		private var _isOver:Boolean = false;
		
		//The gap between the rating icons fetched from the skin
		private var gap:Number = 0;
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  rating to label
		//----------------------------------
		
		//Rating to Label Function
		private var _ratingToLabel:Function;
		
		/**
		 * Takes a function that gets an String for the label from the
		 * rating. The default is a Function that takes the rating and appends a %
		 * to it. 
		 * @return 
		 * 
		 */
		public function get ratingToLabel():Function
		{
			return _ratingToLabel;
		}

		public function set ratingToLabel(v:Function):void
		{
			_ratingToLabel = v;
		}
		
		
		//----------------------------------
		//  rating
		//----------------------------------

		//The current rating 
		private var _rating:Number;
		
		//Indicates if rating has changed
		private var _bRatingChanged:Boolean;
		
		
		/**
		 * The rating of the component (0..100) 
		 * @return the rating
		 * 
		 */
		public function get rating():Number
		{
			return _rating;
		}

		public function set rating(v:Number):void
		{
			if (_rating != v) {
				_rating = v;
				_bRatingChanged = true;
				invalidateProperties();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  enabled
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function set enabled(value:Boolean):void
		{
			if (value == enabled)
				return;
			
			super.enabled = value;
			if (openButton)
				openButton.enabled = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden Methods
		//
		//-------------------------------------------------------------------------- 
		
		/**
		 *  Leverage the SkinStates
		 */ 
		override protected function getCurrentSkinState():String
		{
			return !enabled ? "disabled" : _isOpen ? "open" : _isOver ? "over" : "normal";
		}   
		
		/**
		 * Overriden.
		 * Add behaviours to the SkinParts and setup the containers with the icons
		 *  @private
		 */ 
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if (instance == openButton)
			{
				openButton = setupOpenButton(Group (openButton));
			}
			
			//Add Icons to the active Group. I decided not to use dynamic skin parts for the icons
			//The Icons are passed via styles and are not defined inside the skin. The Holder is defined
			//in the skin and works as a static skin-part. 
			if (instance == activeGroup) {
				setupIconContainer(activeGroup, this.getStyle("ratingIcon"), NUM_OF_RATING_ICONS);
				ratingMask = applyMask (DisplayObject(instance));
				range = activeGroup.width - (activeGroup.left + activeGroup.right);
				colorizeGroup(DisplayObject(activeGroup), uint(this.getStyle("activeIconColor")));
			}
			
			//Add Icons to the passive Group. I decided not to use dynamic skin parts for the icons
			//The Icons are passed via styles and are not defined inside the skin. The Holder is defined
			//in the skin and works as a static skin-part. 
			if (instance == passiveGroup) {
				setupIconContainer(instance, this.getStyle("ratingIcon"), NUM_OF_RATING_ICONS);
				colorizeGroup(DisplayObject(instance), uint(this.getStyle("passiveIconColor")));
			}
		}
		
		/**
		 * Overriden.
		 * Cleans up the skins-parts when they are removed by the framework.
		 * Remove EventListeners that have been added when part was added
		 */
		override protected function partRemoved(partName:String, instance:Object):void
		{
			if (instance == openButton) {
				openButton.removeEventListener(FlexEvent.BUTTON_DOWN, dropDownButton_buttonDownHandler);
				openButton.removeEventListener(MouseEvent.MOUSE_OVER, dropDownButton_buttonOverHandler);
				openButton.removeEventListener(MouseEvent.MOUSE_OUT, dropDownButton_buttonOutHandler);
			}
			
			super.partRemoved(partName, instance);
		}
		
		/**
		 * Overriden.
		 * Manage the properties that are used and centralize updates here.
		 *  @private
		 */ 
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (_bRatingChanged) {
				updateMasks();
				updateLabel();
				_bRatingChanged = false;
			}
		}  
		
		//--------------------------------------------------------------------------
		//
		//  New Methods
		//
		//--------------------------------------------------------------------------   
		
		
		/**
		 *  Opens the dropDown. 
		 */ 
		public function openDropDown():void
		{
			_isOpen = true;
			addMoveHandlers();
			invalidateSkinState();
			this.dispatchEvent(new DropDownEvent(DropDownEvent.OPEN));
		}
		
		/**
		 *  Closes the dropDown. 
		 *   
		 */
		public function closeDropDown():void
		{
			_isOpen = false;
			_isOver = false;
			removeMoveHandlers();
			invalidateSkinState();
			this.dispatchEvent(new DropDownEvent(DropDownEvent.CLOSE));
		}
		
		/**
		 * Update the masks based on the ratings 
		 * 
		 */
		private function updateMasks():void {
			
				ratingMask.width = rating * range/100;
				ratingMask.height = activeGroup.height + 2;
				
				buttonMask.width = openButton.width + 1;
				buttonMask.height = rating/100 * openButton.height + 1;
				buttonMask.y = openButton.height - buttonMask.height + 1;
		}
		
		/**
		 * Updates the label from the rating 
		 */
		private function updateLabel():void {
			if (labelText) {
				var label:String = ratingToLabel(rating);
				labelText.text = label;
			}
		}
		public static const fibArr:Array = [0,0.5,1,2,3,5,8,13,20,40,100];
		/**
		 * The default conversion function to turn the rating into the label
		 * This function can be set from the outside if other conversions are
		 * desired. 
		 * @param v the value
		 * @return the String Format of the value
		 * 
		 */
		private function defaultRatingToLabel(v:Number):String {
			tenScale = Math.ceil(v/10)%10;
			if(v>90) tenScale=10;
			return 'Points '+fibArr[tenScale];
		}
		public var tenScale:int;
		
		/**
		 * Setups the Open Button, which is not a Button but a Group that works as a Button.
		 * TODO: Clean this up. Adding the Listeners here is not transparent
		 * @param ob the Group holding the icons
		 * @return the group
		 * 
		 */
		private function setupOpenButton(ob:Group):Group {
			var iconClass:Class = Class(this.getStyle("ratingIcon"));
			if (iconClass) {
				var icon:Group = new iconClass();
				//Note if your extend your skin from SparkSkin (instead of Skin) the baseColor
				//using the baseColor will possibly interact with the colorization feature in SparkSkin
				colorizeGroup(DisplayObject(icon), uint(this.getStyle("baseColor")));
				ob.addElement(icon);
				ob.addEventListener(MouseEvent.MOUSE_DOWN, dropDownButton_buttonDownHandler);
				ob.addEventListener(MouseEvent.MOUSE_OVER, dropDownButton_buttonOverHandler);
				ob.addEventListener(MouseEvent.MOUSE_OUT, dropDownButton_buttonOutHandler);
				ob.height = icon.height;
				ob.width = icon.width;
				
				var icon2:Group = new iconClass();
				colorizeGroup(DisplayObject(icon2), uint(this.getStyle("activeIconColor")));
				ob.addElement(icon2);
				buttonMask = applyMask(DisplayObject(icon2));
			}
			return ob;
		}
		
		/**
		 * Colorize the given DisplayObject with a given color 
		 * @param instance The DisplayObject to colorize
		 * @param color the color to be used for colorization
		 * 
		 */
		private function colorizeGroup(instance:DisplayObject, color:uint):void {
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = ((color & (0xFF << 16)) >> 16) - 0xCC;
            colorTransform.greenOffset = ((color & (0xFF << 8)) >> 8) - 0xCC;
            colorTransform.blueOffset = (color & 0xFF) - 0xcc;
            colorTransform.alphaMultiplier = 1;
            instance.transform.colorTransform = colorTransform;
		}
		
		/**
		 * Applies a Mask to a given container 
		 * @param container the Container to mask
		 * @return The Filled Element that is used as the mask (i.e part of the mask)
		 */
		private function applyMask(container:DisplayObject):FilledElement {
			var mask:Group = new Group();
			var rect:Rect = new Rect();
			var fill:SolidColor = new SolidColor(0xff0000,1);
			rect.fill = fill;
			mask.addElement(rect);
			container.mask = mask;
			return rect;
		}
		
		/**
		 * Setup the container containing the icons for the active and the passive group.
		 * Fills the container with n icons of the passed class (Class Reference to a MXML-Component)
		 * @param container the container to fill
		 * @param iconClass the ClassReference to the MXML-Component to use as a symbol
		 * @param numOfIcons numer of icons to fill in
		 * 
		 */
		private function setupIconContainer(container:Object, iconClass:Class, numOfIcons:int):void {
			if (iconClass && container) {
				var c:HGroup = HGroup (container);
				c.verticalAlign = VerticalAlign.MIDDLE;
				var w:int = 0;
				gap = c.gap;
				var icn:Group;
				for (var i:int = 0; i < numOfIcons; i++) {
					icn = new iconClass();
					w += icn.width + gap;
					c.addElement(icn);
				}
				w = numOfIcons * icn.width + (numOfIcons - 1) * gap;
				c.width = w;
				c.height = icn.height;
			}
		}
		
		/**
		 * Add HouseEventListeners when DropDown is open 
		 */
		protected function addMoveHandlers():void {
			openButton.systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler);
			openButton.systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler);
			openButton.systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, systemManager_mouseMoveHandler);
			openButton.systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, systemManager_mouseUpHandler);
		}
		
		/**
		 * Remove MouseEventListeners when DropDown is closed
		 */
		protected function removeMoveHandlers():void {
			openButton.systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler);
			openButton.systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler);
			openButton.systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, systemManager_mouseMoveHandler);
			openButton.systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, systemManager_mouseUpHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers. 
		// 	Note there is a DropDownController in the Flex API which
		//  you might want to use. I decided not to extend from it since most of the methods
		// 	cant be overwritten. I'm implementing the Controller Code here.
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * Handler for MouseMove.
		 * In the case of moving the mouse over the ratings, update the rating an the
		 * mask in thes skin to reveal the active parts 
		 * @param event
		 * 
		 */
		protected function systemManager_mouseMoveHandler(event:MouseEvent):void {
			//Check for dropDown. Make sure the butt is down and the target is within the dropDown container
			if (dropDown && event.buttonDown && dropDown.contains(DisplayObject(event.target))) {
				var pt:Point = new Point (event.stageX, event.stageY);
				pt = passiveGroup.globalToContent(pt);
				var h:Number = Math.min(Math.max(0, pt.x), range);
				rating = h/range*100;
			}
		}
		
		/**
		 * Handler for a mouse up that occured anyware.
		 * In this case close the DropDown 
		 * @param event
		 * 
		 */
		protected function systemManager_mouseUpHandler(event:MouseEvent):void {
		 	closeDropDown();
		}
		
		/**
		 * Handler for MouseDown Event on Open Button
		 * Toggles the visibility of the DropDown 
		 * @param event
		 */
		protected function dropDownButton_buttonDownHandler (event:MouseEvent):void {
			if (_isOpen) {
				closeDropDown();
			} else {
				openDropDown();
			}
		}
		
		protected function dropDownButton_buttonOverHandler (event:MouseEvent):void {
			_isOver = true;
			invalidateSkinState();
		}
		
		protected function dropDownButton_buttonOutHandler (event:MouseEvent):void {
			_isOver = false;
			invalidateSkinState();
		}
	}
}