<div>
	<div class="d-flex bg-light" style="border: ridge;">
		<div id="container-for-icon-image"
			style="display: inline-block;">
			<img src="./resources/images/sql/Addition.png" style="width: 50px; height: 50px;"></img>
		</div>
		<div style="display: inline-block;">
			<div id="container-for-icon-names">
				<div style="display: inline-block; font-weight: bold;">Name :</div>
				<div id="addition-name" style="display: inline-block;"></div>
			</div>
			<div>
				<div style="display: inline-block; font-weight: bold;">Key :</div>
				<div id="addition-key" style="display: inline-block;"></div>
			</div>
		</div>
	</div>
	<div id="addition-add-col-conainer" style="display: block;">
		<div style="display: flex; min-block-size: 350px;max-block-size: 350px;font-size: 12px;">
			<div class="col-sm-6 container-for-addition-setting" style="overflow-y: auto;overflow-x: auto;border: ridge;">
				<div style="font-weight: bold;margin: 10px;">Columns</div>
				<div class="child-data-table-div">
					<table id="additon-table" border="1" class="table table-sm table-bordered" style="margin:0px;">
						<tr>
							<th>Column Name</th>
							<th>Type</th>
						</tr>
					</table>
				</div>
			</div>
			<div class="col-sm-6 container-for-addition-setting" style="overflow-y: auto;border: ridge;overflow-x: auto;">
				<div style="font-weight: bold;margin: 10px;">Operaters</div>
				<div>
					<div id="additon-operaters-div" class="operaters-div" style="display:none;">
						<div><span>MIN</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>MAX</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>AVG</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
						<div><span>SUM</span><span>(</span><span class="selected-col-type"></span><span>)</span></div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="container-for-addition-setting" style="font-weight: bold; border: ridge;">
				<div style="font-weight: bold;">
					<div>Col Name</div>
					<div>
						<input type="text" class="form-control" id="addition-col-name"/>
					</div>
				</div>
				<div class="container-for-data-list" style="font-weight: bold;">
					<div>Expression</div>
					<div>
						<textarea id='addition-expression' class="form-control" rows="" cols=""></textarea>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-end">
				<button class="btn btn-outline-secondary" onclick="controller.add('Addition')">Add</button>
			</div>
		</div>
		<div style="border: ridge;">
			<div style="font-weight: bold;">Add Columns</div>
			<div class="expression-result-table-div">
				<table id="add-col-expression-table" class="table table-sm table-bordered" border="1">
					<tr>
						<th>Column</th>
						<th>Expression</th>
					</tr>
				</table>
			</div>
		</div>
		<div class="d-flex justify-content-end">
			<div style="display: inline-block;">
				<button class="btn btn-outline-secondary" onclick="controller.apply('Addition')">Apply</button>
			</div>
			<div style="display: inline-block;">
				<button class="btn btn-outline-secondary">Reset</button>
			</div>
		</div>
	</div>
</div>