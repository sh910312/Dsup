
<div style="border: black solid 1px;">
	<div id="container-for-icon-image"
		style="display: inline-block; border: black solid 1px;">
		<img src="./resources/images/sql/Order.png" style="width: 50px; height: 50px;"></img>
	</div>
	<div style="display: inline-block;">
		<div id="container-for-icon-names">
			<div style="display: inline-block; font-weight: bold;">Name :</div>
			<div id="order-name" style="display: inline-block;"></div>
		</div>
		<div>
			<div style="display: inline-block; font-weight: bold;">Key :</div>
			<div id="order-key" style="display: inline-block;"></div>
		</div>
	</div>
</div>
<div>Columns</div>
<div style="font-weight: bold; border: black solid 1px;">
	<div id="order-contents-container" class="child-data-table-div">
		<table id="order-table" border="1"></table>
	</div>
</div>
<div>
	<div>
		<button onclick="controller.add('Order')">Add</button>
	</div>
</div>
<div>Sort Order</div>
<div style="font-weight: bold; border: black solid 1px;">
	<div class="add-col-expression-table">
		<table id="sort-order-table" border="1">
			<tr>
				<td>Column</td>
				<td>Expression</td>
			</tr>
		</table>
	</div>
</div>
<div>
	<button>Delete</button>
</div>
<div>
	<div style="display: inline-block;">
		<button onclick="controller.apply('Order')">Apply</button>
	</div>
	<div style="display: inline-block;">
		<button>Reset</button>
	</div>
</div>