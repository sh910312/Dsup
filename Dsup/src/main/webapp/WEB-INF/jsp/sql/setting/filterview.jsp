
<div style="border: 1px solid black">
	<div>
		<div id="container-for-icon-image"
			style="display: inline-block; border: black solid 1px;">
			<img src="./resources/images/sql/Filter.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div style="display: inline-block;">
			<div>
				<div style="display: inline-block; font-weight: bold;">Name :</div>
				<div id="filter-type" style="display: inline-block;"></div>
			</div>
			<div>
				<!--  <div>Desc :</div> -->
				<div style="display: inline-block; font-weight: bold;">Key :</div>
				<div id="filter-key" style="display: inline-block;"></div>
			</div>
		</div>
	</div>
	<div style="border: 1px solid black">
		<div>
			<div></div>
			<div id="filter-table-name"></div>
		</div>
		<div class="child-data-table-div">
			<table id="filter-table-list" border=1></table>
		</div>
	</div>
	<div style="border: 1px solid black">
		<div>Expression</div>
		<div>
			<textarea id="fiter-expression"></textarea>
		</div>
		<div>
			<button onclick="controller.apply('Filter')">Apply</button>
			<button onclick="#">Delete</button>
		</div>
	</div>
</div>