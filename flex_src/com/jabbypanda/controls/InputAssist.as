package com.jabbypanda.controls {

	import com.jabbypanda.data.SearchModes;
	import com.jabbypanda.event.HighlightItemListEvent;
	import com.jabbypanda.event.InputAssistEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.core.ContainerGlobals;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.managers.FocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.SystemManager;
	import mx.styles.CSSStyleDeclaration;
	
	import spark.components.PopUpAnchor;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.TextOperationEvent;
	import spark.utils.LabelUtil;
    
    use namespace mx_internal;
	
    /**
     *  The color of the background for highlighted text segments 
     *
     *   @default 0#FFCC00
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    [Style(name="highlightBackgroundColor", type="uint", format="Color", inherit="no", theme="spark")]
    
	[Event (name="select", type="com.jabbypanda.event.InputAssistEvent")]		
	public class InputAssist extends SkinnableComponent {
		                
        [Bindable]
        public var maxRows : Number = 6;
        
        public var minChars : Number = 1;                       
        
        public var requireSelection : Boolean = false;
        
        public var forceOpen : Boolean = true;
        
        public var enumClass : Class;
		        
       /* [SkinPart(required="true",type="spark.components.PopUpAnchor")]
		public var popUp : PopUpAnchor;*/
        
        [SkinPart(required="true",type="odyssey.common.component.HighlightItemList")]
        public var list : HighlightItemList;
        
        [SkinPart(required="true",type="spark.components.TextInput")]
        public var inputTxt : TextInput;
		        
        // Define a static variable.
        private static var classConstructed:Boolean = classConstruct();
        
        // Define a static method.
        private static function classConstruct():Boolean {
            var customListStyles : CSSStyleDeclaration;
                        
            if (!FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration("com.jabbypanda.controls.InputAssist")) {
                // If there is no CSS definition for HighlightItemList 
                // then create one and set the default value.
                customListStyles = new CSSStyleDeclaration();
                customListStyles.defaultFactory = function() : void {
                    this.highlightBackgroundColor = 0x00FF00;                    
                }
                                 
                FlexGlobals.topLevelApplication.styleManager.setStyleDeclaration("com.jabbypanda.controls.InputAssist", customListStyles, true);                                
            }                        
            
            return true;
        }
        
        public function InputAssist() {
            super();
            this.mouseEnabled = true;            
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);            
        }        
                        
        [Bindable]
        public function set dataProvider(value:Object) : void {
            if (value is Array) {
        		_collection = new ArrayCollection(value as Array);
            }
        	else if (value is ArrayCollection) {
        		_collection = value as ArrayCollection;                
        	}
                            	
            _dataProviderChanged = true;
            invalidateProperties(); 
        }
		
        public function get dataProvider() : Object {
            return _collection; 
        }		                
		
        public function set labelField(field:String) : void {
			_labelField = field; 
			if (list) {
                list.labelField = field;   
            } 
		}
		
        public function get labelField() : String { 
            return _labelField;
        };
        
        public function set searchMode(searchMode : String) : void {            
            _searchMode = searchMode; 
            if (list) {
                list.searchMode = searchMode;   
            } 
        }
                
        public function get searchMode() : String { 
            return _searchMode;
        };
		
        public function set labelFunction(func:Function) : void {
        	_labelFunction = func; 
        	if (list) {
                list.labelFunction = func;   
            } 
        }
        
        public function get labelFunction() : Function	 { 
            return _labelFunction; 
        }                		       
        
        public function get selectedItem() : Object { 
            return _selectedItem; 
        }
        
        public function set selectedItem(item : Object) : void {
            _selectedItem = item;
            _previouslyEnteredText = enteredText = returnFunction(_selectedItem);
                        
            _selectedItemChanged = true;
            invalidateProperties();
        }                
		
        // filter function         
        public function filterFunction(item : Object) : Boolean {
        	var itemLabel : String = itemToLabel(item).toLowerCase();
        	// prefix search mode
        	if (searchMode == SearchModes.PREFIX_SEARCH) {
                if (itemLabel.substr(0, enteredText.length) == enteredText.toLowerCase()) {
        			return true;
                }
        		else { 
        			return false;
                }
        	}
        	// infix search mode
        	else {
        		if (itemLabel.search(enteredText.toLowerCase()) != -1) {
                    return true;   
                }
        	}
        	return false;
        }
		
        public function itemToLabel(item : Object) : String {
            return LabelUtil.itemToLabel(item, labelField, labelFunction);
        }
        
        override public function set enabled(value:Boolean) : void {
            super.enabled = value;
            if (inputTxt) {
                inputTxt.enabled = value;   
            }
        }
        
        
        override public function setFocus() : void {            
            if (inputTxt) {
                inputTxt.setFocus();
            }
        }
                        
        // Override the styleChanged() method to detect changes in your new style.
        override public function styleChanged(styleProp:String):void {
                        
            super.styleChanged(styleProp);
                                    
            // Check to see if style changed. 
            if (styleProp == "highlightBackgroundColor") {
                _highlightBackgroundColorStyleChanged = true; 
                invalidateDisplayList();
                return;
            }
        }
        
        override protected function updateDisplayList(unscaledWidth:Number,
                                                      unscaledHeight:Number):void {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            
            // Check to see if style changed. 
            if (_highlightBackgroundColorStyleChanged) {
                list.setStyle("highlightBackgroundColor", getStyle("highlightBackgroundColor"));
                _highlightBackgroundColorStyleChanged = false;
            }
        }
        
        override protected function partAdded(partName : String, instance : Object) : void {
            super.partAdded(partName, instance)
            
            if (instance == inputTxt) {
                inputTxt.text = _enteredText;
                
                inputTxt.addEventListener(FocusEvent.FOCUS_IN, onInputFieldFocusIn);
                inputTxt.addEventListener(FocusEvent.FOCUS_OUT, onInputFieldFocusOut);
                inputTxt.addEventListener(TextOperationEvent.CHANGE, onInputFieldChange);
                inputTxt.addEventListener(KeyboardEvent.KEY_DOWN, onInputFieldKeyDown);            	
            }
            
            if (instance == list) {
                list.dataProvider = _collection;
                list.labelField = labelField;
                list.labelFunction = labelFunction;
                list.searchMode = searchMode;
                list.requireSelection = requireSelection;
                list.setStyle("highlightBackgroundColor", getStyle("highlightBackgroundColor"));
                //list.styleName = this;
                
                list.addEventListener(HighlightItemListEvent.ITEM_CLICK, onListItemClick);
            }
        }  
        
        override protected function commitProperties():void {            
            
            if (_dataProviderChanged) {                
                _dataProviderChanged = false;                
                list.dataProvider = _collection;                                 
            }
            
            if (_selectedItemChanged) {
                var selectedIndex : int = _collection.getItemIndex(selectedItem);                
                list.selectedIndex = _collection.getItemIndex(selectedItem);
                _selectedItemChanged = false;
            }
            
            // Should be last statement.
            // Don't move it up.
            super.commitProperties();                        
        }
        
        protected function set enteredText(t : String) : void {
            _enteredText = t;
            if (inputTxt) {
                inputTxt.text = t;
            }
            
            if (list) {
                list.lookupValue = _enteredText;
            }
        }
        
        protected function get enteredText() : String {
            return _enteredText;
        }
        
        protected function acceptCompletion() : void {                        
            if (_collection.length > 0 && list.selectedIndex >= 0) {
                _completionAccepted = true;                
                selectedItem = _collection.getItemAt(list.selectedIndex);
                //hidePopUp();
            }
            else {
                _completionAccepted = false;
                selectedItem = null;
                restoreEnteredTextAndHidePopUp(!_completionAccepted);
            }
            
            var e:InputAssistEvent = new InputAssistEvent(InputAssistEvent.SELECT, _selectedItem);
            dispatchEvent(e);                         			
        }
        
        protected function filterData() : void {
            _collection.filterFunction = filterFunction;                        	
            _collection.refresh();    
                        
            /*if (_collection.length == 0) {                
                hidePopUp();
            } else if (!isDropDownOpen) {
                if (forceOpen || enteredText.length > 0) {
                    showPopUp();        
                }                
            }*/
        }
        
        private function returnFunction(item : Object) : String {
            if (item == null) {
                return "";   
            }
			
            if (labelField) {
            	return item[labelField];
            }
            else {
            	return itemToLabel(item);
            }
        }                
        
        private function onInputFieldChange(event : TextOperationEvent = null) : void {
            _completionAccepted = false;
            enteredText = inputTxt.text;            
            filterData();
        }
        
        private function onInputFieldKeyDown(event: KeyboardEvent) : void {        	            
            switch (event.keyCode) {
                case Keyboard.UP:
                case Keyboard.DOWN:
                case Keyboard.END:
                case Keyboard.HOME:
                case Keyboard.PAGE_UP:
                case Keyboard.PAGE_DOWN: 
                    list.focusListUponKeyboardNavigation(event);                                     			
                    break;                   
                case Keyboard.ENTER:
                    acceptCompletion();
                    break;
                case Keyboard.TAB:
                case Keyboard.ESCAPE:
                    restoreEnteredTextAndHidePopUp(!_completionAccepted);
                    break;
            }            
        }
        
       /* private function hidePopUp() : void {
            popUp.popUp.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, onMouseDownOutside);
            popUp.displayPopUp = false;            
        }*/
        
     /*   private function showPopUp() : void {            
            popUp.displayPopUp = true;
            
            if (requireSelection) {
                list.selectedIndex = 0;
            }
            else {
                list.selectedIndex = -1;
            }
            
            if (list.dataGroup) {
                list.dataGroup.verticalScrollPosition = 0;
                list.dataGroup.horizontalScrollPosition = 0;
            }
            
            popUp.popUp.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, onMouseDownOutside);
        }*/
        
        private function restoreEnteredTextAndHidePopUp(restoreEnteredText : Boolean) : void {
            if (restoreEnteredText) {
                enteredText = _previouslyEnteredText;
            }
            
            //hidePopUp();
        }                
        
        /*private function get isDropDownOpen() : Boolean {
            return popUp.displayPopUp;
        }*/
                
        private function onInputFieldFocusIn(event : FocusEvent) : void {            
            if (forceOpen) {
            	filterData();
            }
            
            _previouslyEnteredText = enteredText;
        }
        
        private function onInputFieldFocusOut(event : FocusEvent) : void {
            restoreEnteredTextAndHidePopUp(false);            
        }		        				
                
        private function onListItemClick(event : HighlightItemListEvent) : void {                        
            acceptCompletion();            
            event.stopPropagation();
        }
        
        private function onMouseDownOutside(event:FlexMouseEvent) : void {            
            var mouseDownInsideComponent : Boolean = false;            
            var clickedObject : DisplayObjectContainer = event.relatedObject as DisplayObjectContainer;
                        
            while (!(clickedObject.parent is SystemManager)) {                
                if (clickedObject == this) {
                    mouseDownInsideComponent = true;
                    break;
                }
                
                clickedObject = clickedObject.parent;
            }
                        
            if (!mouseDownInsideComponent) {                
                restoreEnteredTextAndHidePopUp(!_completionAccepted);
            }
        }
                
        private function onFlexWindowActivate(event : FlexEvent) : void {
            /* reset lastFocus value to prevent shifting focus 
               to previously selected component
            */
            (focusManager as FocusManager).lastFocus = null;                        
        }
        
        private function onAddedToStage(event : Event) : void {            
            focusManager.addEventListener(FlexEvent.FLEX_WINDOW_ACTIVATE, onFlexWindowActivate);
        }
                                    
        private var _collection : ArrayCollection = new ArrayCollection();
    
        private var _completionAccepted : Boolean;
        
        private var _dataProviderChanged : Boolean;        
                
        private var _enteredText : String = "";
        
        private var _highlightBackgroundColorStyleChanged : Boolean;
        
        private var _labelField : String;
        
        private var _labelFunction : Function;
        
        private var _previouslyEnteredText : String = "";
        
        private var _searchMode : String = SearchModes.INFIX_SEARCH;
        
        private var _selectedItem : Object;
        
        private var _selectedItemChanged : Boolean;
               
    }
		
}