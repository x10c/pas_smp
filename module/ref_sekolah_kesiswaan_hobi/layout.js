/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_sekolah_kesiswaan_hobi;
var m_ref_sekolah_kesiswaan_hobi_d = _g_root +'/module/ref_sekolah_kesiswaan_hobi/';

function M_RefSekolahKesiswaanHobi(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_hobi' }
		,	{ name	: 'nm_hobi' }
		,	{ name	: 'kd_kel_hobi' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_sekolah_kesiswaan_hobi_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.store_kel_hobi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_sekolah_kesiswaan_hobi_d +'data_kel_hobi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_kel_hobi = new Ext.form.ComboBox({
			store			: this.store_kel_hobi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_nm_hobi = new Ext.form.TextField({
		allowBlank	: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Kelompok Hobi'
			, dataIndex		: 'kd_kel_hobi'
			, sortable		: true
			, editor		: this.form_kel_hobi
			, renderer		: combo_renderer(this.form_kel_hobi)
			, align			: 'center'
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_kel_hobi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'nm_hobi'
			, header		: 'Nama Hobi'
			, dataIndex		: 'nm_hobi'
			, sortable		: true
			, editor		: this.form_nm_hobi
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});


	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id			: 'ref_sekolah_kesiswaan_hobi_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_hobi'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_hobi		: ''
			,	nm_hobi		: ''
			,	kd_kel_hobi	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				params  : {
						id_hobi		: record.data['id_hobi']
					,	nm_hobi		: record.data['nm_hobi']
					,	kd_kel_hobi	: record.data['kd_kel_hobi']
					,	dml_type	: this.dml_type
				}
			,	url		: m_ref_sekolah_kesiswaan_hobi_d +'submit.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_kel_hobi.load({
				callback	: function(){
					this.store.load();
				}
			,	scope		: this
		});		
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (this.ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (this.ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

m_ref_sekolah_kesiswaan_hobi = new M_RefSekolahKesiswaanHobi('Hobi');

//@ sourceURL=m_ref_sekolah_kesiswaan_hobi.layout.js
