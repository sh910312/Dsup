<div id="container-for-icon-info" class="d-flex bg-light" style="border: ridge;">
	<div id="container-for-icon-image" style="display: inline-block;">
		<img src="./resources/images/sql/Union.png"
			style="width: 50px; height: 50px;"></img>
	</div>
	<div id="container-for-icon-names" style="display: inline-block;">
		<div>
			<div style="display: inline-block; font-weight: bold;">Type :</div>
			<div id="union-momo-type" style="display: inline-block;"></div>
		</div>
		<div>
			<div style="display: inline-block; font-weight: bold;">Key :</div>
			<div id="union-momo-key" style="display: inline-block;"></div>
		</div>
	</div>
</div>
<div class="d-flex bg-light" style="border: ridge;">
	<div style="display: inline-block;">
		<div style="font-weight: bold;">Master Table</div>
		<div class="master-select-div">
			<select id="union-master-select" class="form-control form-control-sm">
			</select>
		</div>
	</div>
	<div style="display: inline-block;">
		<div style="font-weight: bold;">Union Type</div>
		<div class="type-select-div">
			<select id="union-type-select" class="form-control form-control-sm">
				<option value="UNION">Union</option>
				<option value="UNION ALL">Union All</option>
				<option value="MINUS">Minus</option>
				<option value="INTERSECT">Intersect</option>
			</select>
		</div>
	</div>
</div>
<div id="union-contents-container" style="border: ridge; display: flex;font-size: 12px;max-block-size: 300px;">
	<div class="col-sm-6 container-for-union-setting" style="overflow-y: auto;overflow-x: auto;padding: 0px;">
		<div style="display: flex;margin: 10px 0px 10px 0px;align-items: center;">
			<div id="union-master-mark-div-1" style="font-weight: bold;">
				<p style="margin: 0px 10px 0px 10px;">Master</p>
			</div>
			<div id="union-dataTableName-1" class="union-dataTableName"></div>
		</div>
		<div class="child-data-table-div">
			<table id="union-dataTable-1" class="table table-sm table-bordered" border="1" style="margin: 0px">
				<tr>
					<th>Columns</th>
					<th>Data Type</th>
				</tr>
			</table>
		</div>
	</div>
	<div class="col-sm-6 container-for-union-setting" style="overflow-y: auto;overflow-x: auto;padding: 0px;">
		<div style="display: flex;margin: 10px 0px 10px 0px;align-items: center;">
			<div id="union-master-mark-div-2" style="font-weight: bold;">
				<p style="margin: 0px 10px 0px 10px;">Slave</p>
			</div>
			<div id="union-dataTableName-2" class="union-dataTableName"></div>
		</div>
		<div class="child-data-table-div">
			<table id="union-dataTable-2" class="table table-sm table-bordered" border="1" style="margin: 0px;">
				<tr>
					<th>Columns</th>
					<th>Data Type</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="d-flex justify-content-end">
	<div style="display: inline-block;">
		<input type="radio" name="union-add-type" class="union-add-type"
			value="Manual" checked="checked">Manual
	</div>
	<div style="display: inline-block;">
		<input type="radio" name="union-add-type" class="union-add-type"
			value="Auto">Auto
	</div>
	<div style="display: inline-block;">
		<button class="form-control form-control-sm" onclick="controller.add('Union')">Add</button>
	</div>
</div>
<div style="align-items: center;overflow-y: auto;overflow-x: auto; border: ridge; font-size: 12px; min-block-size: 200px; max-block-size: 200px;">
	<table id="union-match-table" class="table table-sm table-bordered" border="1" style="margin:0px;">
		<thead>
			<tr>
				<th>Column</th>
				<th>matching Columns</th>
				<th>Type</th>
			</tr>
		</thead>
	</table>
</div>
<div class="d-flex justify-content-end">
	<div style="display: inline-block;">
		<button class="form-control form-control-sm" onclick="controller.apply('Union')">Apply</button>
	</div>
	<div style="display: inline-block;">
		<button class="form-control form-control-sm">Reset</button>
	</div>
</div>
