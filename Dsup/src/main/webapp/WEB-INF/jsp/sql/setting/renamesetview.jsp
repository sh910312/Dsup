<div style="display:flex; border: black solid 1px;">
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
<div style="border: black solid 1px;">
	<div>
		<div style="font-weight: bold;">From Columns</div>
		<div class="container-for-addition-setting">
			<div>
				<table id="rename-table" border="1">
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
<div>
	<button onclick="controller.add('Rename')">Add</button>
</div>
<div style="border: black solid 1px;">
	<div style="font-weight: bold;">To Columns</div>
	<div>
		<div>
			<table id="rename-add-table" border="1">
				<tr>
					<th>Column Name</th>
					<th>Type</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<div style="display: flex;">
	<div>
		<button onclick="controller.apply('Rename')">Apply</button>
	</div>
	<div>
		<button>Reset</button>
	</div>
</div>