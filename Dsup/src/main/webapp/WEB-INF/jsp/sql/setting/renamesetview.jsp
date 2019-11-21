<div style="display:flex;border: ridge;">
	<div id="container-for-icon-image">
		<img src="./resources/images/sql/Rename.png" style="width: 50px; height: 50px; margin-right: 10px"></img>
	</div>
	<div>
		<div id="container-for-icon-names" style="display: flex;">
			<div style="font-weight: bold;">Name :</div>
			<div id="rename-name"></div>
		</div>
		<div style="display: flex;">
			<div style="font-weight: bold;">Key :</div>
			<div id="rename-key"></div>
		</div>
	</div>
</div>
<div style="border: ridge;">
	<div>
		<div style="font-weight: bold;">From Columns</div>
		<div class="container-for-addition-setting" style="min-block-size: 350px;max-block-size: 350px;overflow-y: auto;overflow-x: auto;font-size: 10px;">
			<div>
				<table id="rename-table" class="table table-sm table-bordered" border="1" style="border: ridge;margin: 0px">
					<tr>
						<th>Visible</th>
						<th>From</th>
						<th>Type</th>
						<th>To</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<div class="d-flex justify-content-end">
	<button class="btn btn-outline-secondary" onclick="controller.add('Rename')">Add</button>
</div>
<div style="border: ridge;">
	<div style="font-weight: bold;">To Columns</div>
	<div>
		<div style="min-block-size: 200px;max-block-size: 200px;overflow-y: auto;overflow-x: auto;font-size: 11px">
			<table class="table table-sm table-bordered" id="rename-add-table" border="1" style="margin: 0px;">
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
		<button class="btn btn-outline-secondary" onclick="controller.apply('Rename')">Apply</button>
	</div>
	<div>
		<button class="btn btn-outline-secondary">Reset</button>
	</div>
</div>