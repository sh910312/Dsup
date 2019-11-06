var myDiagram;
var controller;
$(function() {
	var height = window.innerHeight || document.body.clientHeight;
	jQuery('body, html').css("height", "100%");
	if (window.goSamples)
		goSamples(); // init for these samples -- you don't need to call this
	var $ = go.GraphObject.make; // for conciseness in defining templates
	
	controller = Controller.getInstance();
	jQuery(function(){
		jQuery(".master-select-div select").change(function(obj){
			//alert("변경!");
			controller.selectChanged(obj.currentTarget);
		});
	});
	jQuery(document).on("change", ".order_type, .dbinsert-select, .dbinsert-add-type, .union-add-type, .where-stmt-select", function(obj){
		controller.selectChanged(obj.currentTarget);
	});
	jQuery(document).on("change","#target_table_list", function(obj){
		controller.getTargetTableInfo();
	});
	//동적으로 생성된 태그에 이벤트를 걸려면 어떻게 해야할까??
	//출처: https://rongscodinghistory.tistory.com/41 [악덕고용주의 개발 일기]
	jQuery.singleDoubleClick = function(singleClk, doubleClk) {
		    return (function() {
		      var alreadyclicked = false;
		      var alreadyclickedTimeout;

		      return function(e) {
		        if (alreadyclicked) {
		          // double
		          alreadyclicked = false;
		          alreadyclickedTimeout && clearTimeout(alreadyclickedTimeout);
		          doubleClk && doubleClk(e);
		        } else {
		          // single
		          alreadyclicked = true;
		          alreadyclickedTimeout = setTimeout(function() {
		            alreadyclicked = false;
		            singleClk && singleClk(e);
		          }, 300);
		        }
		      }
		    })();
		  }
	jQuery(document).on('click', '.child-data-table-div tr, #additon-operaters-div div', jQuery.singleDoubleClick(function(e){
		  //single click.
		controller.tableClick(e.currentTarget);
		}, function(e){
		  //double click.
			controller.tableDoubleClick(e.currentTarget);
		}));
	myDiagram = $(go.Diagram, "myDiagramDiv", // must name or refer to the DIV
	// HTML element
	{
		grid : $(go.Panel, "Grid", $(go.Shape, "LineH", {
			stroke : "lightgray",
			strokeWidth : 0.5
		}), $(go.Shape, "LineH", {
			stroke : "gray",
			strokeWidth : 0.5,
			interval : 10
		}), $(go.Shape, "LineV", {
			stroke : "lightgray",
			strokeWidth : 0.5
		}), $(go.Shape, "LineV", {
			stroke : "gray",
			strokeWidth : 0.5,
			interval : 10
		})),
		"draggingTool.dragsLink" : true,
		"draggingTool.isGridSnapEnabled" : true,
		"linkingTool.isUnconnectedLinkValid" : true,
		"linkingTool.portGravity" : 20,
		"relinkingTool.isUnconnectedLinkValid" : true,
		"relinkingTool.portGravity" : 20,
		"relinkingTool.fromHandleArchetype" : $(go.Shape, "Diamond", {
			segmentIndex : 0,
			cursor : "pointer",
			desiredSize : new go.Size(8, 8),
			fill : "tomato",
			stroke : "darkred"
		}),
		"relinkingTool.toHandleArchetype" : $(go.Shape, "Diamond", {
			segmentIndex : -1,
			cursor : "pointer",
			desiredSize : new go.Size(8, 8),
			fill : "darkred",
			stroke : "tomato"
		}),
		"linkReshapingTool.handleArchetype" : $(go.Shape, "Diamond", {
			desiredSize : new go.Size(7, 7),
			fill : "lightblue",
			stroke : "deepskyblue"
		}),
		"rotatingTool.handleAngle" : 270,
		"rotatingTool.handleDistance" : 30,
		"rotatingTool.snapAngleMultiple" : 15,
		"rotatingTool.snapAngleEpsilon" : 15,
		"undoManager.isEnabled" : true
	});

	// when the document is modified, add a "*" to the title and enable the
	// "Save" button
	myDiagram.addDiagramListener("Modified", function(e) {
		//console.log("수정 발생")
		var button = document.getElementById("SaveButton");
		if (button)
			button.disabled = !myDiagram.isModified;
		var idx = document.title.indexOf("*");
		if (myDiagram.isModified) {
			if (idx < 0)
				document.title += "*";
		} else {
			if (idx >= 0)
				document.title = document.title.substr(0, idx);
		}
	});
	var first = true;
	myDiagram.mouseDrop = function(e) {
		console.log("momo drop");
		var key_prefix = myDiagram.selection.first().data.text;
		var key_suffix = makeStrKey();
		//myDiagram.selection.first().data.key = key_prefix + "_" + key_suffix;
		var first_node = myDiagram.selection.first();
		var start_node = myDiagram.findNodeForKey("FIRST");
		var momoCnt = myDiagram.nodes.count;
		//cnt = iconCnt-1;
		momoCnt = momoCnt - 1;
		controller.momoDrop(momoCnt);
		//command.setIsFirst(momoCnt);
		
		if(first){
			myDiagram.add(
					$(go.Link,{selectionAdornmentTemplate : linkSelectionAdornmentTemplate},
							{ fromNode: start_node, toNode: first_node },
							$(go.Shape)
					));			
			first=false;
		}
		//console.log("실행");
		save();
		//load();
		//momoClick();
	}
	
	function momoClick(){
		var node = myDiagram.selection.first();
		var momoKey = myDiagram.selection.first().data.key;
		var momoType = myDiagram.selection.first().data.text;
		var childs = new Array();
		node.findNodesInto().each(function(i) {
			if(i.data.txt != "Start"){
				childs.push(i.data.key);
			}
		})
		
		controller.momoClick(momoKey, momoType, childs);
	}

	// Define a function for creating a "port" that is normally transparent.
	// The "name" is used as the GraphObject.portId, the "spot" is used to
	// control how links connect
	// and where the port is positioned on the node, and the boolean "output"
	// and "input" arguments
	// control whether the user can draw links from or to the port.
	function makePort(name, spot, output, input) {
		// the port is basically just a small transparent square
		return $(go.Shape, "Circle", {
			fill : null, // not seen, by default; set to a translucent gray
			// by showSmallPorts, defined below
			stroke : null,
			desiredSize : new go.Size(7, 7),
			alignment : spot, // align the port on the main Shape
			alignmentFocus : spot, // just inside the Shape
			portId : name, // declare this object to be a "port"
			fromSpot : spot,
			toSpot : spot, // declare where links may connect at this port
			fromLinkable : output,
			toLinkable : input, // declare whether the user may draw links
			// to/from here
			cursor : "pointer" // show a different cursor to indicate potential
		// link point
		});
	}
	var nodeSelectionAdornmentTemplate = $(go.Adornment, "Auto", $(go.Shape, {
		fill : null,
		stroke : "deepskyblue",
		strokeWidth : 1.5,
		strokeDashArray : [ 4, 2 ]
	}), $(go.Placeholder));
	var nodeResizeAdornmentTemplate = $(go.Adornment, "Spot", {
		locationSpot : go.Spot.Right
	}, $(go.Placeholder), $(go.Shape, {
		alignment : go.Spot.TopLeft,
		cursor : "nw-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.Top,
		cursor : "n-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.TopRight,
		cursor : "ne-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.Left,
		cursor : "w-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.Right,
		cursor : "e-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.BottomLeft,
		cursor : "se-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.Bottom,
		cursor : "s-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		alignment : go.Spot.BottomRight,
		cursor : "sw-resize",
		desiredSize : new go.Size(6, 6),
		fill : "lightblue",
		stroke : "deepskyblue"
	}));
	var nodeRotateAdornmentTemplate = $(go.Adornment, {
		locationSpot : go.Spot.Center,
		locationObjectName : "CIRCLE"
	}, $(go.Shape, "Circle", {
		name : "CIRCLE",
		cursor : "pointer",
		desiredSize : new go.Size(7, 7),
		fill : "lightblue",
		stroke : "deepskyblue"
	}), $(go.Shape, {
		geometryString : "M3.5 7 L3.5 30",
		isGeometryPositioned : true,
		stroke : "deepskyblue",
		strokeWidth : 1.5,
		strokeDashArray : [ 4, 2 ]
	}));

	myDiagram.nodeTemplate = $(go.Node, "Spot", {
		locationSpot : go.Spot.Center
	}, new go.Binding("location", "loc", go.Point.parse)
			.makeTwoWay(go.Point.stringify), {
		selectable : true,
		selectionAdornmentTemplate : nodeSelectionAdornmentTemplate
	}, {
		resizable : true,
		resizeObjectName : "PANEL",
		resizeAdornmentTemplate : nodeResizeAdornmentTemplate
	}, {
		rotatable : true,
		rotateAdornmentTemplate : nodeRotateAdornmentTemplate
	}, new go.Binding("angle").makeTwoWay(),

	// the main object is a Panel that surrounds a TextBlock with a Shape
	$(go.Panel, "Auto", {
		name : "PANEL"
	}, {
		margin : 2,
		click : momoClick
//		mouseEnter : function(e, obj, prev) { // change group's background
//			// brush
//			console.log(myDiagram.isModified)
//		}
	}, new go.Binding("desiredSize", "size", go.Size.parse)
			.makeTwoWay(go.Size.stringify), $(go.Picture, "./resources/images/sql/Default.png",
			{
				portId : "",
				fromLinkable : true,
				toLinkable : true,
				background : "gray",
				width : 50,
				height : 50,
				cursor : "pointer"
			}, new go.Binding("source")), $(go.TextBlock, {
		font : "bold 7pt Helvetica, Arial, sans-serif",
		margin : 8,
		maxSize : new go.Size(160, NaN),
		wrap : go.TextBlock.WrapFit,
		editable : true
	}, new go.Binding("text").makeTwoWay())),

	// four small named ports, one on each side:
	makePort("T", go.Spot.Top, false, true), makePort("L", go.Spot.Left, true,
			true), makePort("R", go.Spot.Right, true, true), makePort("B",
			go.Spot.Bottom, true, false), { // handle mouse enter/leave events
		// to show/hide the ports
		mouseEnter : function(e, node) {
			showSmallPorts(node, true);
		},
		mouseLeave : function(e, node) {
			showSmallPorts(node, false);
		}
	}, {
		contextMenu : // define a context menu for each node
		$("ContextMenu", "Spot", // that has several buttons around
		$(go.Placeholder, {
			padding : 5
		}), // a Placeholder object
		$("ContextMenuButton", $(go.TextBlock, "Show Data"), {
			alignment : go.Spot.Right,
			alignmentFocus : go.Spot.Left,
			click : function(){
				var node = myDiagram.selection.first();
				var momoKey = myDiagram.selection.first().data.key;
				var momoType = myDiagram.selection.first().data.text;
				
				controller.showData(momoKey);
			}
		}))
	// end Adornment
	});
	
	function showSmallPorts(node, show) {
		node.ports.each(function(port) {
			if (port.portId !== "") { // don't change the default port, which
				// is the big shape
				port.fill = show ? "rgba(0,0,0,.3)" : null;
			}
		});
	}
	var linkSelectionAdornmentTemplate = $(go.Adornment, "Link", $(go.Shape,
	// isPanelMain declares that this Shape shares the Link.geometry
	{
		isPanelMain : true,
		fill : null,
		stroke : "deepskyblue",
		strokeWidth : 0
	}) // use selection object's strokeWidth
	);
	myDiagram.linkTemplate = $(go.Link, // the whole link panel
	{
		selectable : true,
		selectionAdornmentTemplate : linkSelectionAdornmentTemplate
	}, {
		relinkableFrom : true,
		relinkableTo : true,
		reshapable : true
	}, {
		routing : go.Link.AvoidsNodes,
		curve : go.Link.JumpOver,
		corner : 5,
		toShortLength : 4
	}, // new go.Binding("points").makeTwoWay(),
	$(go.Shape, // the link path
	// shape
	{
		isPanelMain : true,
		strokeWidth : 2
	}), $(go.Shape, // the arrowhead
	{
		toArrow : "Standard",
		stroke : null
	}), $(go.Panel, "Auto", new go.Binding("visible", "isSelected").ofObject(),
			$(go.Shape, "RoundedRectangle", // the link shape
			{
				fill : "#F8F8F8",
				stroke : null
			}), $(go.TextBlock, {
				textAlign : "center",
				font : "10pt helvetica, arial, sans-serif",
				stroke : "#919191",
				margin : 2,
				minSize : new go.Size(10, NaN),
				editable : true
			}, new go.Binding("text").makeTwoWay())));

	load(); // load an initial diagram from some JSON text
	// initialize the Palette that is on the left side of the page
	myPalette = $(go.Palette, "myPaletteDiv", // must name or refer to the DIV
	// HTML element
	{
		layout: $(go.GridLayout,
				{
					cellSize: new go.Size(100, 100),
					wrappingColumn: 10
				}),  
		maxSelectionCount : 1,
		nodeTemplateMap : myDiagram.nodeTemplateMap, // share the templates
		// used by myDiagram
		linkTemplate : // simplify the link template, just in this Palette
		$(go.Link, { // because the GridLayout.alignment is Location and the
			// nodes have locationSpot == Spot.Center,
			// to line up the Link in the same manner we have to pretend the
			// Link has the same location spot
			locationSpot : go.Spot.Center,
			selectionAdornmentTemplate : $(go.Adornment, "Link", {
				locationSpot : go.Spot.Center
			}, $(go.Shape, {
				isPanelMain : true,
				fill : null,
				stroke : "deepskyblue",
				strokeWidth : 0
			}), $(go.Shape, // the arrowhead
			{
				toArrow : "Standard",
				stroke : null
			}))
		}, {
			routing : go.Link.AvoidsNodes,
			curve : go.Link.JumpOver,
			corner : 5,
			toShortLength : 4
		}, // new go.Binding("points"),
		$(go.Shape, // the link path shape
		{
			isPanelMain : true,
			strokeWidth : 2
		}), $(go.Shape, // the arrowhead
		{
			toArrow : "Standard",
			stroke : null
		}))
	});

	function makeStrKey() {
		var id = mixStr();

		// model.findNodeDataForKey(id) : 해당 하는 key가 기존의 node에 있는가? return
		// boolean
		while (myDiagram.model.findNodeDataForKey(id))
			id = mixStr();

		function mixStr() {
			var text = "";
			var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

			for (var i = 0; i < 2; i++)
				text += possible.charAt(Math.floor(Math.random()
						* possible.length));

			return text;
		}
		//console.log("[생성되 ID] : " + id);
		return id;
	}
	//var context = "${pageContext.request.contextPath }";
	// makeUniqueKeyFunction : model이 생성되기 전에 설정?
	myPalette.model = $(go.GraphLinksModel, {
		//makeUniqueKeyFunction : makeStrKey,
		nodeDataArray : [ {
			text : "DBread",
			source : "./resources/images/sql/DBread.png",
			key : "DBread_" + makeStrKey()
		}, {
			text : "Filter",
			source :  "./resources/images/sql/Filter.png",
			key : "Filter_" + makeStrKey()
		}, {
			text : "Join",
			source :  "./resources/images/sql/Join.png",
			key : "Join_" + makeStrKey()
		}, {
			text : "Union",
			source : "./resources/images/sql/Union.png",
			key : "Union_" + makeStrKey()
		},{
			text : "Addition",
			source : "./resources/images/sql/Addition.png",
			key : "Addition_" + makeStrKey()
		},{
			text : "Rename",
			source : "./resources/images/sql/Rename.png",
			key : "Rename_" + makeStrKey()
		},{
			text : "Group",
			source : "./resources/images/sql/Group.png",
			key : "Group_" + makeStrKey()
		}, {
			text : "Order",
			source : "./resources/images/sql/Order.png",
			key : "Order_" + makeStrKey()
		}, {
			text : "DBinsert",
			source : "./resources/images/sql/DBinsert.png",
			key : "DBinsert_" + makeStrKey()
		} ]
	});
});
function save() {
	document.getElementById("mySavedModel").value = myDiagram.model.toJson();
	myDiagram.isModified = false;
}
function load() {
	console.log("load()");
	var json = document.getElementById("mySavedModel").value;
	// go.Model.fromJson(json) : JSON to String
	myDiagram.model = go.Model.fromJson(json);
}