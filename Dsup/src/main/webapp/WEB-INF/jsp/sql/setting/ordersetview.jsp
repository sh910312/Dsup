<div class="d-flex bg-light" style="border: ridge;">
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
<div style="border: ridge;">
	<div style="font-weight: bold; ">Columns</div>
	<div style="">
		<div id="order-contents-container" class="child-data-table-div">
			<table id="order-table" class="table table-bordered table-sm" border="1" style="margin: 0px;">
				<tr>
					<th>Column Name</th>
					<th>Type</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="d-flex justify-content-end">
	<div>
		<button class="btn btn-outline-secondary" onclick="controller.add('Order')">Add</button>
	</div>
</div>
<div style="border: ridge;">
	<div style="font-weight: bold; ">Sort Order</div>
	<div>
		<div class="add-col-expression-table">
			<table id="sort-order-table" class="table table-bordered table-sm" border="1" style="margin:0px;max-block-size: 100px;overflow-y: auto;overflow-x: auto;font-size: 12px;">
				<tr>
					<th>Column</th>
					<th>Expression</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="d-flex justify-content-end">
	<div style="display: inline-block;">
		<button class="btn btn-outline-secondary" onclick="controller.apply('Order')">Apply</button>
	</div>
	<div style="display: inline-block;">
		<button class="btn btn-outline-secondary">Reset</button>
	</div>
</div>