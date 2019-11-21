<div class="d-flex bg-light" style="border: ridge;">
	<div id="container-for-icon-image"
		style="display: inline-block;">
		<img src="./resources/images/sql/DBread.png"
			style="width: 50px; height: 50px;"></img>
	</div>
	<div style="display: inline-block;">
		<div id="container-for-icon-names">
			<div style="display: inline-block; font-weight: bold;">Name :</div>
			<div id="dbread-name" style="display: inline-block;"></div>
		</div>
		<div>
			<div style="display: inline-block; font-weight: bold;">Key :</div>
			<div id="dbread-key" style="display: inline-block;"></div>
		</div>
	</div>
</div>
<div id="container-for-icon-info" style="border: ridge;">
	<div style="padding: 15px;" class="container">
		<div style="text-align: center;"><h6>Query Statement</h6></div>
		<div style="height: 200px;">
			<textarea id="sql-statement" class="form-control h-100"></textarea>
		</div>
	</div>
</div>
<div id="apply-container" class="d-flex justify-content-end" style="">
	<div >
		<button id="dbread-apply" class="btn btn-outline-secondary" onclick="controller.apply('DBread');">Apply</button>
	</div>
	<div>
		<button id="dbread-cancel" class="btn btn-outline-secondary" onclick="">Cancel</button>
	</div>
</div>
