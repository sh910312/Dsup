
<div id="sidebar-container" style="">
	<div id="container-for-icon-info" class="d-flex bg-light" style="display:flex;border:ridge">
		<div id="container-for-icon-image" style="margin-right: 20px;">
			<img src="./resources/images/sql/Join.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div id="container-for-icon-names">
			<div>
				<div style="display:inline-block; font-weight: bold;">Type : </div>
				<div id="join-momo-type" style="display:inline-block;"></div>
			</div>
			<div>
				<div style="display:inline-block; font-weight: bold;">Key : </div>
				<div id="join-momo-key" style="display:inline-block;"></div>
			</div>
		</div>
	</div>
	<div id="container-for-join-type" style="font-size: 13px;display:flex;border:ridge">
		<div>
			<input type="radio" name="joinType" value="INNER JOIN" checked="checked">Inner Join
		</div>
		<div>
			<input type="radio" name="joinType" value="RIGHT OUTER JOIN">Right Outer Join 
		</div>
		<div>
			<input type="radio" name="joinType" value="LEFT OUTER JOIN">Left Outer Join
		</div> 
	</div>
	<div id="join-contents-container" style="display:flex; font-size: 12px;min-block-size: 300px;max-block-size: 300px;">
		<div class="container-for-join-setting" style="overflow-y: auto;overflow-x: auto;border:ridge"> 
			<div id="join-dataTableName-1" class="join-dataTableName" style="font-weight: bold; margin-right: 20px;"></div>
			<div class="child-data-table-div">
				<table id="join-dataTable-1" class="table table-sm table-bordered" border="1">
					<tr>
						<th>Column Name</th>
						<th>Type</th>
					</tr>
				</table>
			</div>
		</div>
		<div class="container-for-join-setting" style="overflow-y: auto;overflow-x: auto;border:ridge"> 
			<div id="join-dataTableName-2" class="join-dataTableName" style="font-weight: bold;"></div>
			<div class="child-data-table-div">
				<table id="join-dataTable-2" class="table table-sm table-bordered" border="1" style="margin: 0px;">
					<tr>
						<th>Column Name</th>
						<th>Type</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="container-for-join-button" class="d-flex justify-content-end">
		<button class="btn btn-outline-secondary" onclick="controller.add('Join')">Join</button>
	</div>
	<div id="container-for-join-key" style="border:ridge">
		<div style="font-weight: bold;">Join Expression</div>
		<div style = "min-height: 100px;max-height: 100px">
			<ul id="join-expression" style="margin: 0px; padding-inline-start: 30px;">
			</ul>
		</div>
	</div>
<!-- 	<div id="container-for-cancel-key">
		<div>
			<input type="checkbox" name="productType" value="product">Catesian Product
		</div>
		<div style>
			<button class="btn btn-outline-secondary">Delete</button>
		</div>
	</div> -->
	<div id="container-for-apply" class="d-flex justify-content-end">
		<div style="display:inline-block;">
			<button class="btn btn-outline-secondary" onclick="controller.apply('Join')">Apply</button>
		</div>
		<div style="display:inline-block;">
			<button class="btn btn-outline-secondary">Cancel</button>
		</div>
	</div>
</div>