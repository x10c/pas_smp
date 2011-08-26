/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var set_win_thn_ajaran;

/* fix for hidden button in RowEditor when grid height is set to auto */
Ext.override(Ext.grid.GridView, {
	getEditorParent: function() {
		return document.body;
	}
});

function MyRowEditor(obj) {
	return new Ext.ux.grid.RowEditor({
		saveText	: 'Simpan'
	,	cancelText	: 'Batal'
	,	clicksToEdit: 2
	,	listeners	: {
			canceledit: function(roweditor, state) {
				if (state === true) {
					obj.do_cancel();
				}
			}
		,	afteredit: function(roweditor, object, record, idx) {
				obj.do_save(record);
			}
		}
	});
}

function combo_renderer(combo)
{
        return function(value) {
                var idx = combo.store.find(combo.valueField, value);
                if (idx < 0) {
                        return value;
                }
                var rec = combo.store.getAt(idx);
                return rec ? rec.get(combo.displayField) : "";
        }
}

function store_renderer(valueField, displayField, store)
{
	return function(v) {
		var i = store.find(valueField, v);
		if (i < 0) {
			return v;
		}
		var rec = store.getAt(i);
		return rec ? rec.get(displayField) : "";
	}
}

function checkbox_renderer(checkbox, str_true, str_false)
{
	return function(value) {
		if (value == '1' || value == 'true' || value == true) {
			return str_true;
		} else {
			return str_false;
		}
	}
}

function showTahunAjaran()
{
	var	spot = new Ext.ux.Spotlight({
			easing		: 'easeOut'
		,	duration	: .3
	});

	if (typeof showTahunAjaran.thn_ajaran_ds == 'undefined') {
		showTahunAjaran.thn_ajaran_ds = new Ext.data.SimpleStore({
				fields		: ['id', 'name']
			,	url			: _g_root +'/module/login/tahun_pelajaran.jsp'
			,	autoLoad	: true
			});
	}

	if (typeof showTahunAjaran.periode_ds == 'undefined') {
		showTahunAjaran.periode_ds = new Ext.data.SimpleStore({
				fields		: ['id', 'name']
			,	url			: _g_root +'/module/login/periode_belajar.jsp'
			,	autoLoad	: true
			});
	}

	if (typeof showTahunAjaran.thn_ajaran_form == 'undefined') {
		showTahunAjaran.thn_ajaran_form = new Ext.form.ComboBox({
				fieldLabel		: 'Tahun Pelajaran'
			,	name			: 'thn_ajaran'
			,	hiddenName		: 'thn_ajaran'
			,	store			: showTahunAjaran.thn_ajaran_ds
			,	valueField		: 'id'
			,	displayField	: 'name'
			,	selectOnFocus	: true
			,	mode			: 'local'
			,	triggerAction	: 'all'
			,	forceSelection	: true
			,	allowBlank		: false
			,	editable		: false
			,	blankText		: 'Tahun Pelajaran harus dipilih.'
			});
	}

	if (typeof showTahunAjaran.periode_form == 'undefined') {
		showTahunAjaran.periode_form = new Ext.form.ComboBox({
				fieldLabel		: 'Periode Belajar'
			,	name			: 'periode'
			,	hiddenName		: 'periode'
			,	store			: showTahunAjaran.periode_ds
			,	valueField		: 'id'
			,	displayField	: 'name'
			,	selectOnFocus	: true
			,	mode			: 'local'
			,	triggerAction	: 'all'
			,	forceSelection	: true
			,	allowBlank		: false
			,	editable		: false
			,	blankText		: 'Periode harus dipilih.'
			});
	}

	if (typeof showTahunAjaran.form_thn_ajaran == 'undefined') {
		showTahunAjaran.form_thn_ajaran = new Ext.form.FormPanel({
				baseCls		: 'x-plain'
			,	url			: _g_root +'/module/login/submit_tahun_pelajaran.jsp'
			,	labelWidth	: 120
			,	labelAlign	: 'right'
			,	items		: [
					showTahunAjaran.thn_ajaran_form
				,	showTahunAjaran.periode_form
				]
			});
	}

	if (typeof set_win_thn_ajaran == 'undefined') {
		set_win_thn_ajaran = new Ext.Window({
			title		: '<center> Tahun Pelajaran dan Periode Belajar </center>'
		,	id			: 'win_thn_ajaran'
		,	width		: 370
		,	height		: 150
		,	closable	: false
		,	resizable	: false
		,	draggable	: false
		,	layout		: 'fit'
		,	plain		: true
		,	bodyStyle	: 'padding:5px;'
		,	buttonAlign	: 'center'
		,	items		: showTahunAjaran.form_thn_ajaran
		,	buttons		: [{
				text	: 'OK'
			,	id		: 'btn_ok'
			,	handler :
					function() {
						var panel_submit = set_win_thn_ajaran.getComponent(0);
						if (panel_submit.form.isValid()) {
							panel_submit.form.submit({
								params: {
									tahun_pelajaran	: showTahunAjaran.thn_ajaran_form.value
								,	periode_belajar	: showTahunAjaran.periode_form.value
								}
							,	waitMsg: 'Pemuatan ...'
							,	failure:
									function(form, action) {
										Ext.MessageBox.alert('Error Message', action.result.errorInfo);
									}
							,	success:
									function(form, action) {
										set_win_thn_ajaran.hide();
										window.location = _g_root +'/module/main/index.jsp';
									}
							});
							spot.hide();
						} else {
							Ext.MessageBox.alert('Errors', 'Tahun Pelajaran & Periode harus di isi');
						}
					}
			}]
		,	defaultButton	: 'btn_ok'
		});
	}

	showTahunAjaran.thn_ajaran_ds.on('load', function() {
		showTahunAjaran.thn_ajaran_form.setValue(showTahunAjaran.thn_ajaran_ds.getAt(0).get('id'));
	});

	showTahunAjaran.periode_ds.on('load', function() {
		showTahunAjaran.periode_form.setValue(showTahunAjaran.periode_ds.getAt(0).get('id'));
	});

	set_win_thn_ajaran.show();
	spot.show('win_thn_ajaran');
	set_win_thn_ajaran.syncSize();
}

/*
 * Add filtering on Ext.form.ComboBox
 */
Ext.form.ComboBox.prototype.filterBy = function(fn, scope) {
	var ds = this.store;

	ds.filterBy(fn, scope);
	ds.realSnapshot = ds.snapshot;
	ds.snapshot = ds.data;
};

Ext.form.ComboBox.prototype.clearFilter = function(suppressEvent) {
	var ds = this.store;

	if (ds.realSnapshot && ds.realSnapshot != ds.snapshot) {
		ds.snapshot = ds.realSnapshot;
		delete ds.realSnapshot;
	}
	ds.clearFilter(suppressEvent);
};

/*
 * Add some space between label and form.
 */
Ext.form.FormPanel.prototype.labelSeparator	=' : ';
Ext.form.FieldSet.prototype.labelSeparator	=' : ';

/*
 * show warning 'allowBlank:false' in the right side of the form.
 */
Ext.form.Field.prototype.msgTarget = 'side';

/*
 * Hiding series in Chart.
 * @ref: http://technopaper.blogspot.com/2010/06/hiding-series-in-extjs-charts.html
 */
Ext.override(Ext.chart.Chart, {
    setSeriesStylesByIndex: function(index, styles){
        this.swf.setSeriesStylesByIndex(index, Ext.encode(styles));
    }
});

/*
 * Dynamically add/remove field in grid.
 * @ref: http://www.sencha.com/forum/showthread.php?53009-Adding-removing-fields-and-columns
 */
Ext.override(Ext.data.Store,{
	addField: function(field){
		field = new Ext.data.Field(field);
		this.recordType.prototype.fields.replace(field);
		if(typeof field.defaultValue != 'undefined'){
			this.each(function(r){
				if(typeof r.data[field.name] == 'undefined'){
					r.data[field.name] = field.defaultValue;
				}
			});
		}
		delete this.reader.ef;
		this.reader.buildExtractors();
	},
	removeField: function(name){
		this.recordType.prototype.fields.removeKey(name);
		this.each(function(r){
			delete r.data[name];
			if(r.modified){
				delete r.modified[name];
			}
		});
		delete this.reader.ef;
		this.reader.buildExtractors();
	}
});

Ext.override(Ext.grid.ColumnModel,{
	addColumn: function(column, colIndex){
		if(typeof column == 'string'){
			column = {header: column, dataIndex: column};
		}
		var config = this.config;
		this.config = [];
		if(typeof colIndex == 'number'){
			config.splice(colIndex, 0, column);
		}else{
			colIndex = config.push(column);
		}
		this.setConfig(config);
		return colIndex;
	},
	removeColumn: function(colIndex){
		var config = this.config;
		this.config = [config[colIndex]];
		config.splice(colIndex, 1);
		this.setConfig(config);
	}
});

Ext.override(Ext.grid.GridPanel,{
	addColumn: function(field, column, colIndex){
		if(!column){
			if(field.dataIndex){
				column = field;
				field = field.dataIndex;
			} else{
				column = field.name || field;
			}
		}
		this.store.addField(field);
		return this.colModel.addColumn(column, colIndex);
	}
,	removeColumn: function(name, colIndex){
		this.store.removeField(name);
		if(typeof colIndex != 'number'){
			colIndex = this.colModel.findColumnIndex(name);
		}
		if(colIndex >= 0){
			this.colModel.removeColumn(colIndex);
		}
	}
,	loadMask: true
});

/**
 * Highchart
 * - set default export url.
 * - disabled print button and credits.
 */
Highcharts.setOptions ({
	credits		: {
		enabled	: false
	}
,	exporting	: {
		url	: _g_root +'/highcharts/export.jsp'
	,	buttons	: {
			printButton	: {
				enabled: false
			}
		}
	}
});

function left(str, n){
    if (n <= 0)
        return "";
    else if (n > String(str).length)
        return str;
    else
        return String(str).substring(0,n);
}

function right(str, n){
    if (n <= 0)
       return "";
    else if (n > String(str).length)
       return str;
    else {
       var iLen = String(str).length;
       return String(str).substring(iLen, iLen - n);
    }
}

