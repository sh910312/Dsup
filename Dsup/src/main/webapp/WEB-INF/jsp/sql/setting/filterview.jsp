
<div style="">
	<div class="d-flex bg-light" style="border: ridge;">
		<div id="container-for-icon-image"
			style="display: inline-block;">
			<img src="./resources/images/sql/Filter.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div style="display: inline-block;">
			<div>
				<div style="display: inline-block; font-weight: bold;">Name :</div>
				<div id="filter-type" style="display: inline-block;"></div>
			</div>
			<div>
				<div style="display: inline-block; font-weight: bold;">Key :</div>
				<div id="filter-key" style="display: inline-block;"></div>
			</div>
		</div>
	</div>
	<div style="border:min-block-size: 350px;max-block-size: 350px;overflow-y: auto;overflow-x: auto;font-size: 12px;">
		<div>
			<div></div>
			<div id="filter-table-name"></div>
		</div>
		<div class="child-data-table-div">
			<table id="filter-table-list" class="table table-bordered table-sm" style="margin:0px;border: ridge;" border=1>
				<tr>
					<th>Column Name</th>
					<th>Type</th>
				</tr>
			</table>
		</div>
	</div>
	<div style="min-block-size: 150px;max-block-size: 150px;border: ridge;">
		<div style="font-weight: bold;text-align: center;">Expression</div>
		<div class="container" style="height:110px">
			<textarea id="fiter-expression" class="form-control h-100"></textarea>
		</div>
	</div>
	<div class="d-flex justify-content-end">
		<button class="btn btn-outline-secondary" onclick="controller.apply('Filter')">Apply</button>
		<button class="btn btn-outline-secondary" onclick="#">Delete</button>
	</div>
</div>