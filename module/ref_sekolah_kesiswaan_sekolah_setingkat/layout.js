/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_sekolah_kesiswaan_sekolah_setingkat;
var m_ref_sekolah_kesiswaan_sekolah_setingkat_d = _g_root +'/module/ref_sekolah_kesiswaan_sekolah_setingkat/';

function M_RefSekolahKesiswaanSekolahSetingkat(title)
{
	this.title			= title;
	this.dml_type		= 0;
	this.ha_level		= 0;
	this.id_propinsi	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'asal_smp' }
		,	{ name	: 'id_pro' }
		,	{ name	: 'id_kab' }
		,	{ name	: 'nm_sekolah' }
		,	{ name	: 'kd_jenis_sekolah' }
		,	{ name	: 'kd_status_sekolah' }
		,	{ name	: 'alamat_sekolah' }
		,	{ name	: 'no_telp' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_sekolah_kesiswaan_sekolah_setingkat_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.store_propinsi = new Ext.data.ArrayStore({
			fields		: ['id_pro','nm_propinsi']
		,	url			: m_ref_sekolah_kesiswaan_sekolah_setingkat_d +'data_propinsi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kabupaten = new Ext.data.ArrayStore({
			fields		: ['id_pro','id_kab','nm_kabupaten']
		,	url			: m_ref_sekolah_kesiswaan_sekolah_setingkat_d +'data_kabupaten.jsp'
		,	idIndex		: 1
		,	autoLoad	: false
	});

	this.store_jenis_sekolah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_sekolah_kesiswaan_sekolah_setingkat_d +'data_jenis_sekolah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_sekolah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_sekolah_kesiswaan_sekolah_setingkat_d +'data_status_sekolah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_propinsi = new Ext.form.ComboBox({
			store			: this.store_propinsi
		,	valueField		: 'id_pro'
		,	displayField	: 'nm_propinsi'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listeners	: {
					scope	: this
				,	select	: function(cb, record, index) {
						this.form_propinsi_on_select(record.get('id_pro'));
					}
			}
	});

	this.form_kabupaten = new Ext.form.ComboBox({
			store			: this.store_kabupaten
		,	valueField		: 'id_kab'
		,	displayField	: 'nm_kabupaten'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});
	
	this.form_nm_sekolah = new Ext.form.TextField({
		allowBlank	: false
	});

	this.form_jenis_sekolah = new Ext.form.ComboBox({
			store			: this.store_jenis_sekolah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_status_sekolah = new Ext.form.ComboBox({
			store			: this.store_status_sekolah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_alamat_sekolah = new Ext.form.TextArea({
		allowBlank	: false
	});

	this.form_no_telp = new Ext.form.TextField({
			allowBlank		: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Propinsi'
			, dataIndex		: 'id_pro'
			, sortable		: true
			, editor		: this.form_propinsi
			, renderer		: combo_renderer(this.form_propinsi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_propinsi
				,	labelField	: 'nm_propinsi'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Kabupaten'
			, dataIndex		: 'id_kab'
			, sortable		: true
			, editor		: this.form_kabupaten
			, renderer		: combo_renderer(this.form_kabupaten)
			, width			: 200
			}
		,	{ header		: 'Nama Sekolah'
			, dataIndex		: 'nm_sekolah'
			, sortable		: true
			, editor		: this.form_nm_sekolah
			, width			: 250
			, filterable	: true
			}
		,	{ header		: 'Jenis Sekolah'
			, dataIndex		: 'kd_jenis_sekolah'
			, sortable		: true
			, editor		: this.form_jenis_sekolah
			, renderer		: combo_renderer(this.form_jenis_sekolah)
			, aliign		: 'center'
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_jenis_sekolah
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Status Sekolah'
			, dataIndex		: 'kd_status_sekolah'
			, sortable		: true
			, editor		: this.form_status_sekolah
			, renderer		: combo_renderer(this.form_status_sekolah)
			, aliign		: 'center'
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_status_sekolah
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'alamat_sekolah'
			, header		: 'Alamat Sekolah'
			, dataIndex		: 'alamat_sekolah'
			, sortable		: true
			, editor		: this.form_alamat_sekolah
			, filterable	: true
			}
		,	{ header		: 'No.Telp'
			, dataIndex		: 'no_telp'
			, sortable		: true
			, editor		: this.form_no_telp
			, width			: 75
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
			id			: 'ref_sekolah_kesiswaan_sekolah_setingkat_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'alamat_sekolah'
		,	bbar		: new Ext.PagingToolbar({
				store	: this.store
			,	pageSize: 50
			,	plugins	: [this.filters]
			})
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.form_kabupaten_filter = function(r,id)
	{
		return (r.get('id_pro') == this.id_propinsi);
	}

	this.form_propinsi_on_select = function(id_propinsi)
	{
		this.id_propinsi = id_propinsi;

		if (this.id_propinsi != 'undefined'
		&&  this.id_propinsi != '') {
			this.form_kabupaten.clearFilter(true);
			this.form_kabupaten.filterBy(this.form_kabupaten_filter, this);
			this.form_kabupaten.setValue(this.store_kabupaten.getAt(0).get('id_kab'));
		} else {
			this.form_kabupaten.clearFilter(true);
		}
	}

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				asal_smp			: ''
			,	id_propinsi			: ''
			,	id_kabupaten		: ''
			,	nm_sekolah			: ''
			,	kd_jenis_sekolah	: ''
			,	kd_status_sekolah	: ''
			,	alamat_sekolah		: ''
			,	no_telp				: ''
		});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
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
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		Ext.Ajax.request({
				params  : {
						asal_smp			: record.data['asal_smp']
					,	id_propinsi			: record.data['id_pro']
					,	id_kabupaten		: record.data['id_kab']
					,	nm_sekolah			: record.data['nm_sekolah']
					,	kd_jenis_sekolah	: record.data['kd_jenis_sekolah']
					,	kd_status_sekolah	: record.data['kd_status_sekolah']
					,	alamat_sekolah		: record.data['alamat_sekolah']
					,	no_telp				: record.data['no_telp']
					,	dml_type			: this.dml_type
				}
			,	url		: m_ref_sekolah_kesiswaan_sekolah_setingkat_d +'submit.jsp'
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

	this.set_button = function()
	{
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
	}

	this.do_load = function()
	{
		this.store_propinsi.load({
				callback	: function(){
					this.store_kabupaten.load({
							callback	: function(){
								this.store_jenis_sekolah.load({
										callback	: function(){
											this.store_status_sekolah.load({
													callback	: function(){
														this.store.load();
													}
												,	scope		: this
											});
										}
									,	scope		: this
								});
							}
						,	scope		: this
					});
				}
			,	scope		: this
		});
		
		this.set_button();
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

		this.do_load();
	}
}

m_ref_sekolah_kesiswaan_sekolah_setingkat = new M_RefSekolahKesiswaanSekolahSetingkat('Sekolah Setingkat');

//@ sourceURL=m_ref_sekolah_kesiswaan_sekolah_setingkat.layout.js
