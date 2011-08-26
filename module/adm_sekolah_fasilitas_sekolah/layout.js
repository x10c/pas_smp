/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_sekolah_fasilitas_sekolah;
var m_adm_sekolah_fasilitas_sekolah_properti_sekolah;
var m_adm_sekolah_fasilitas_sekolah_perlengkapan_sekolah;
var m_adm_sekolah_fasilitas_sekolah_perlengkapan_kbm;
var m_adm_sekolah_fasilitas_sekolah_ruangan_sekolah;
var m_adm_sekolah_fasilitas_sekolah_pemakaian_listrik;
var m_adm_sekolah_fasilitas_sekolah_buku_sekolah_dan_alat_pendidikan;
var m_adm_sekolah_fasilitas_sekolah_program_inklusi;
var m_adm_sekolah_fasilitas_sekolah_d = _g_root +'/module/adm_sekolah_fasilitas_sekolah/';
var m_adm_sekolah_fasilitas_sekolah_ha_level = 0;

function M_AdmSekolahFasilitasSekolahPropertiSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_penggunaan_tanah' }
		,	{ name	: 'kd_penggunaan_tanah_old' }
		,	{ name	: 'kd_kepemilikan' }
		,	{ name	: 'kd_kepemilikan_old' }
		,	{ name	: 'kd_sertifikat' }
		,	{ name	: 'kd_sertifikat_old' }
		,	{ name	: 'luas' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_properti_sekolah.jsp'
		,	autoLoad	: false
	});
	
	this.store_kd_penggunaan_tanah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_penggunaan_tanah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_kepemilikan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_kepemilikan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_sertifikat = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_sertifikat.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_kd_penggunaan_tanah = new Ext.form.ComboBox({
			store			: this.store_kd_penggunaan_tanah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kd_kepemilikan = new Ext.form.ComboBox({
			store			: this.store_kd_kepemilikan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kd_sertifikat = new Ext.form.ComboBox({
			store			: this.store_kd_sertifikat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_luas = new Ext.form.NumberField({
			allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_keterangan = new Ext.form.TextField({});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Penggunaan Tanah'
			, dataIndex		: 'kd_penggunaan_tanah'
			, sortable		: true
			, editor		: this.form_kd_penggunaan_tanah
			, renderer		: combo_renderer(this.form_kd_penggunaan_tanah)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_penggunaan_tanah
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Kepemilikan'
			, dataIndex		: 'kd_kepemilikan'
			, sortable		: true
			, editor		: this.form_kd_kepemilikan
			, renderer		: combo_renderer(this.form_kd_kepemilikan)
			, width			: 120
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_kepemilikan
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Sertifikat'
			, dataIndex		: 'kd_sertifikat'
			, sortable		: true
			, editor		: this.form_kd_sertifikat
			, renderer		: combo_renderer(this.form_kd_sertifikat)
			, width			: 140
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_sertifikat
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Luas'
			, dataIndex		: 'luas'
			, sortable		: true
			, editor		: this.form_luas
			, align			: 'right'
			, width			: 80
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_fasilitas_sekolah_ha_level == 4) {
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
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
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
				kd_penggunaan_tanah	: ''
			,	kd_kepemilikan		: ''
			,	kd_sertifikat		: ''
			,	luas				: ''
			,	keterangan			: ''
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
						kd_penggunaan_tanah		: record.data['kd_penggunaan_tanah']
					,	kd_penggunaan_tanah_old	: record.data['kd_penggunaan_tanah_old']
					,	kd_kepemilikan			: record.data['kd_kepemilikan']
					,	kd_kepemilikan_old		: record.data['kd_kepemilikan_old']
					,	kd_sertifikat			: record.data['kd_sertifikat']
					,	kd_sertifikat_old		: record.data['kd_sertifikat_old']
					,	luas					: record.data['luas']
					,	keterangan				: record.data['keterangan']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_properti_sekolah.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_kd_penggunaan_tanah.load({
			callback	: function(){
				this.store_kd_kepemilikan.load({
					callback	: function(){
						this.store_kd_sertifikat.load({
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

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_fasilitas_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolahPerlengkapanSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_perlengkapan_sekolah' }
		,	{ name	: 'jumlah' }
		,	{ name	: 'nm_perlengkapan_sekolah' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_perlengkapan_sekolah.jsp'
		,	autoLoad	: false
	});
	
	this.form_jumlah = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_perlengkapan_sekolah'
			, header		: 'Nama Perlengkapan Sekolah'
			, dataIndex		: 'nm_perlengkapan_sekolah'
			, sortable		: true
			, editable		: false
			, filterable	: true
			}
		,	{ header		: 'Jumlah'
			, dataIndex		: 'jumlah'
			, sortable		: true
			, editor		: this.form_jumlah
			, align			: 'center'
			, width			: 120
			, filter		: {
				type		: 'numeric'
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_perlengkapan_sekolah'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

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
						kd_perlengkapan_sekolah	: record.data['kd_perlengkapan_sekolah']
					,	jumlah					: record.data['jumlah']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_perlengkapan_sekolah.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolahPerlengkapanKBM(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_perlengkapan_sekolah' }
		,	{ name	: 'jumlah' }
		,	{ name	: 'nm_perlengkapan_sekolah' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_perlengkapan_kbm.jsp'
		,	autoLoad	: false
	});
	
	this.form_jumlah = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_perlengkapan_sekolah'
			, header		: 'Nama Perlengkapan Sekolah'
			, dataIndex		: 'nm_perlengkapan_sekolah'
			, sortable		: true
			, editable		: false
			, filterable	: true
			}
		,	{ header		: 'Jumlah'
			, dataIndex		: 'jumlah'
			, sortable		: true
			, editor		: this.form_jumlah
			, align			: 'center'
			, width			: 120
			, filter		: {
				type		: 'numeric'
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_perlengkapan_sekolah'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

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
						kd_perlengkapan_sekolah	: record.data['kd_perlengkapan_sekolah']
					,	jumlah					: record.data['jumlah']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_perlengkapan_kbm.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolahRuanganSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.panjang	= 0;
	this.lebar		= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'id_ruang_kelas' }
		,	{ name	: 'nm_ruang_kelas' }
		,	{ name	: 'kd_ruang' }
		,	{ name	: 'kd_kepemilikan' }
		,	{ name	: 'kd_kondisi_ruangan' }
		,	{ name	: 'kapasitas' }
		,	{ name	: 'panjang' }
		,	{ name	: 'lebar' }
		,	{ name	: 'luas' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ruangan_sekolah.jsp'
		,	autoLoad	: false
	});
	
	this.store_kd_ruang = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_jenis_ruangan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_kepemilikan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_kepemilikan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_kondisi_ruangan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_kondisi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_nm_ruang_kelas = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_kd_ruang = new Ext.form.ComboBox({
			store			: this.store_kd_ruang
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kd_kepemilikan = new Ext.form.ComboBox({
			store			: this.store_kd_kepemilikan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kd_kondisi_ruangan = new Ext.form.ComboBox({
			store			: this.store_kd_kondisi_ruangan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kapasitas = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_panjang = new Ext.form.NumberField({
			allowDecimals	: true
		,	allowNegative	: false
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.panjang = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_lebar = new Ext.form.NumberField({
			allowDecimals	: true
		,	allowNegative	: false
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.lebar = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_luas = new Ext.form.NumberField({
			allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_keterangan = new Ext.form.TextField({});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Nama Ruangan'
			, dataIndex		: 'nm_ruang_kelas'
			, sortable		: true
			, editor		: this.form_nm_ruang_kelas
			, width			: 150
			, filterable	: true
			}
		,	{ header		: 'Jenis Ruangan'
			, dataIndex		: 'kd_ruang'
			, sortable		: true
			, editor		: this.form_kd_ruang
			, renderer		: combo_renderer(this.form_kd_ruang)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_ruang
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Kepemilikan'
			, dataIndex		: 'kd_kepemilikan'
			, sortable		: true
			, editor		: this.form_kd_kepemilikan
			, renderer		: combo_renderer(this.form_kd_kepemilikan)
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_kepemilikan
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Kondisi Ruangan'
			, dataIndex		: 'kd_kondisi_ruangan'
			, sortable		: true
			, editor		: this.form_kd_kondisi_ruangan
			, renderer		: combo_renderer(this.form_kd_kondisi_ruangan)
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_kondisi_ruangan
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Kapasitas'
			, dataIndex		: 'kapasitas'
			, sortable		: true
			, editor		: this.form_kapasitas
			, align			: 'center'
			, width			: 80
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Panjang'
			, dataIndex		: 'panjang'
			, sortable		: true
			, editor		: this.form_panjang
			, align			: 'center'
			, width			: 80
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Lebar'
			, dataIndex		: 'lebar'
			, sortable		: true
			, editor		: this.form_lebar
			, align			: 'center'
			, width			: 80
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Luas'
			, dataIndex		: 'luas'
			, sortable		: true
			, editor		: this.form_luas
			, readOnly		: true
			, align			: 'center'
			, width			: 80
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_fasilitas_sekolah_ha_level == 4) {
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
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_compute = function()
	{
		var luas = 0;
		
		luas = this.panjang * this.lebar;
		
		this.form_luas.setValue(luas);
	}
	
	this.do_add = function()
	{
		this.panjang	= 0;
		this.lebar		= 0;

		this.record_new = new this.record({
				id_ruang_kelas		: ''
			,	nm_ruang_kelas		: ''
			,	kd_ruang			: ''
			,	kd_kepemilikan		: ''
			,	kd_kondisi_ruangan	: ''
			,	kapasitas			: ''
			,	panjang				: ''
			,	lebar				: ''
			,	luas				: ''
			,	keterangan			: ''
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
						id_ruang_kelas		: record.data['id_ruang_kelas']
					,	nm_ruang_kelas		: record.data['nm_ruang_kelas']
					,	kd_ruang			: record.data['kd_ruang']
					,	kd_kepemilikan		: record.data['kd_kepemilikan']
					,	kd_kondisi_ruangan	: record.data['kd_kondisi_ruangan']
					,	kapasitas			: record.data['kapasitas']
					,	panjang				: record.data['panjang']
					,	lebar				: record.data['lebar']
					,	luas				: record.data['luas']
					,	keterangan			: record.data['keterangan']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_ruangan_sekolah.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_kd_ruang.load({
			callback	: function(){
				this.store_kd_kepemilikan.load({
					callback	: function(){
						this.store_kd_kondisi_ruangan.load({
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

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_fasilitas_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolahPemakaianListrik(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_sumber_listrik' }
		,	{ name	: 'kd_sumber_listrik_old' }
		,	{ name	: 'kd_daya_listrik' }
		,	{ name	: 'kd_daya_listrik_old' }
		,	{ name	: 'kd_voltase' }
		,	{ name	: 'kd_voltase_old' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_pemakaian_listrik.jsp'
		,	autoLoad	: false
	});
	
	this.store_kd_sumber_listrik = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_sumber_listrik.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_daya_listrik = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_daya_listrik.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_voltase = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_voltase.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_kd_sumber_listrik = new Ext.form.ComboBox({
			store			: this.store_kd_sumber_listrik
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kd_daya_listrik = new Ext.form.ComboBox({
			store			: this.store_kd_daya_listrik
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kd_voltase = new Ext.form.ComboBox({
			store			: this.store_kd_voltase
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Sumber Listrik'
			, dataIndex		: 'kd_sumber_listrik'
			, sortable		: true
			, editor		: this.form_kd_sumber_listrik
			, renderer		: combo_renderer(this.form_kd_sumber_listrik)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_sumber_listrik
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Daya Listrik'
			, dataIndex		: 'kd_daya_listrik'
			, sortable		: true
			, editor		: this.form_kd_daya_listrik
			, renderer		: combo_renderer(this.form_kd_daya_listrik)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_daya_listrik
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Voltase'
			, dataIndex		: 'kd_voltase'
			, sortable		: true
			, editor		: this.form_kd_voltase
			, renderer		: combo_renderer(this.form_kd_voltase)
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_voltase
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

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
						kd_sumber_listrik		: record.data['kd_sumber_listrik']
					,	kd_sumber_listrik_old	: record.data['kd_sumber_listrik_old']
					,	kd_daya_listrik			: record.data['kd_daya_listrik']
					,	kd_daya_listrik_old		: record.data['kd_daya_listrik_old']
					,	kd_voltase				: record.data['kd_voltase']
					,	kd_voltase_old			: record.data['kd_voltase_old']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_pemakaian_listrik.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_kd_sumber_listrik.load({
			callback	: function(){
				this.store_kd_daya_listrik.load({
					callback	: function(){
						this.store_kd_voltase.load({
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

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolahBukuSekolahDanAlatPendidikan(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_mata_pelajaran_diajarkan' }
		,	{ name	: 'jml_jdl_guru' }
		,	{ name	: 'jml_eks_guru' }
		,	{ name	: 'jml_jdl_siswa' }
		,	{ name	: 'jml_eks_siswa' }
		,	{ name	: 'jml_jdl_pegang' }
		,	{ name	: 'jml_eks_pegang' }
		,	{ name	: 'prosen_peraga' }
		,	{ name	: 'paktek' }
		,	{ name	: 'mulmed' }
		,	{ name	: 'nm_mata_pelajaran_diajarkan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_buku_sekolah_dan_alat_pendidikan.jsp'
		,	autoLoad	: false
	});
	
	this.form_jml_jdl_guru = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
	});

	this.form_jml_eks_guru = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
	});

	this.form_jml_jdl_siswa = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
	});

	this.form_jml_eks_siswa = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
	});

	this.form_jml_jdl_pegang = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
	});

	this.form_jml_eks_pegang = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
	});

	this.form_prosen_peraga = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 100
		,	maxText			: 'Nilai Maksimal adalah 100'
	});

	this.form_paktek = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
	});

	this.form_mulmed = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
	});

	/* plugins */
	this.col_hdr1 = [
		{
			colspan	: 2
		}
	,	{
			header	: 'Buku'
		,	colspan	: 6
		,	align	: 'center'
		}
	,	{
			header	: 'Alat Pendidikan'
		,	colspan	: 3
		,	align	: 'center'
		}
	];
	
	this.col_hdr2 = [
		{
			colspan	: 2
		}
	,	{
			header	: 'Pegangan Guru'
		,	colspan	: 2
		,	align	: 'center'
		}
	,	{
			header	: 'Teks Siswa'
		,	colspan	: 2
		,	align	: 'center'
		}
	,	{
			header	: 'Penunjang'
		,	colspan	: 2
		,	align	: 'center'
		}
	,	{
			colspan	: 1
		}
	,	{
			colspan	: 1
		}
	,	{
			colspan	: 1
		}
	];

	this.header = new Ext.ux.grid.ColumnHeaderGroup({
			rows	: [this.col_hdr1, this.col_hdr2]
	});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_mata_pelajaran_diajarkan'
			, header		: 'Mata Pelajaran'
			, dataIndex		: 'nm_mata_pelajaran_diajarkan'
			, sortable		: true
			, editable		: false
			, filterable	: true
			}
		,	{ header		: 'Jumlah Judul'
			, dataIndex		: 'jml_jdl_guru'
			, sortable		: true
			, editor		: this.form_jml_jdl_guru
			, align			: 'center'
			, width			: 50
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Eksemplar'
			, dataIndex		: 'jml_eks_guru'
			, sortable		: true
			, editor		: this.form_jml_eks_guru
			, align			: 'center'
			, width			: 75
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Judul'
			, dataIndex		: 'jml_jdl_siswa'
			, sortable		: true
			, editor		: this.form_jml_jdl_siswa
			, align			: 'center'
			, width			: 50
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Eksemplar'
			, dataIndex		: 'jml_eks_siswa'
			, sortable		: true
			, editor		: this.form_jml_eks_siswa
			, align			: 'center'
			, width			: 75
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Judul'
			, dataIndex		: 'jml_jdl_pegang'
			, sortable		: true
			, editor		: this.form_jml_jdl_pegang
			, align			: 'center'
			, width			: 50
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Eksemplar'
			, dataIndex		: 'jml_eks_pegang'
			, sortable		: true
			, editor		: this.form_jml_eks_pegang
			, align			: 'center'
			, width			: 75
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: '% Peraga thd. Kebutuhan Standar'
			, dataIndex		: 'prosen_peraga'
			, sortable		: true
			, editor		: this.form_prosen_peraga
			, align			: 'center'
			, width			: 100
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Praktik (Paket)'
			, dataIndex		: 'paktek'
			, sortable		: true
			, editor		: this.form_paktek
			, align			: 'center'
			, width			: 75
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Multimedia'
			, dataIndex		: 'mulmed'
			, sortable		: true
			, editor		: this.form_mulmed
			, align			: 'center'
			, width			: 75
			, filter		: {
				type		: 'numeric'
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters, this.header]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_mata_pelajaran_diajarkan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

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
						kd_mata_pelajaran_diajarkan	: record.data['kd_mata_pelajaran_diajarkan']
					,	jml_jdl_guru				: record.data['jml_jdl_guru']
					,	jml_eks_guru				: record.data['jml_eks_guru']
					,	jml_jdl_siswa				: record.data['jml_jdl_siswa']
					,	jml_eks_siswa				: record.data['jml_eks_siswa']
					,	jml_jdl_pegang				: record.data['jml_jdl_pegang']
					,	jml_eks_pegang				: record.data['jml_eks_pegang']
					,	prosen_peraga				: record.data['prosen_peraga']
					,	paktek						: record.data['paktek']
					,	mulmed						: record.data['mulmed']
					,	dml_type					: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_buku_sekolah_dan_alat_pendidikan.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolahProgramInklusi(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_ketunaan' }
		,	{ name	: 'kd_ketunaan_old' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_program_inklusi.jsp'
		,	autoLoad	: false
	});
	
	this.store_ketunaan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_ketunaan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_ketunaan = new Ext.form.ComboBox({
			store			: this.store_ketunaan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Jenis Ketunaan'
			, dataIndex		: 'kd_ketunaan'
			, sortable		: true
			, editor		: this.form_ketunaan
			, renderer		: combo_renderer(this.form_ketunaan)
			, width			: 300
			, filter		: {
					type		: 'list'
				,	store		: this.store_ketunaan
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_fasilitas_sekolah_ha_level == 4) {
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
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
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
				kd_ketunaan	: ''
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
						kd_ketunaan		: record.data['kd_ketunaan']
					,	kd_ketunaan_old	: record.data['kd_ketunaan_old']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_fasilitas_sekolah_d +'submit_program_inklusi.jsp'
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
		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_ketunaan.load({
			callback	: function(){
				this.store.load();
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_fasilitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_fasilitas_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_fasilitas_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSekolahFasilitasSekolah()
{
	m_adm_sekolah_fasilitas_sekolah_properti_sekolah					= new M_AdmSekolahFasilitasSekolahPropertiSekolah('Properti Sekolah');
	m_adm_sekolah_fasilitas_sekolah_perlengkapan_sekolah				= new M_AdmSekolahFasilitasSekolahPerlengkapanSekolah('Perlengkapan Sekolah');
	m_adm_sekolah_fasilitas_sekolah_perlengkapan_kbm					= new M_AdmSekolahFasilitasSekolahPerlengkapanKBM('Perlengkapan KBM');
	m_adm_sekolah_fasilitas_sekolah_ruangan_sekolah						= new M_AdmSekolahFasilitasSekolahRuanganSekolah('Ruangan Sekolah');
	m_adm_sekolah_fasilitas_sekolah_pemakaian_listrik					= new M_AdmSekolahFasilitasSekolahPemakaianListrik('Pemakaian Listrik');
	m_adm_sekolah_fasilitas_sekolah_buku_sekolah_dan_alat_pendidikan	= new M_AdmSekolahFasilitasSekolahBukuSekolahDanAlatPendidikan('Buku Sekolah dan Alat Pendidikan');
	m_adm_sekolah_fasilitas_sekolah_program_inklusi						= new M_AdmSekolahFasilitasSekolahProgramInklusi('Program Inklusi');

	this.panel = new Ext.TabPanel({
			id				: 'adm_sekolah_fasilitas_sekolah_panel'
		,	enableTabScroll	: true
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animScroll		: true
    		}
		,	items			: [
				m_adm_sekolah_fasilitas_sekolah_properti_sekolah.panel
			,	m_adm_sekolah_fasilitas_sekolah_perlengkapan_sekolah.panel
			,	m_adm_sekolah_fasilitas_sekolah_perlengkapan_kbm.panel
			,	m_adm_sekolah_fasilitas_sekolah_ruangan_sekolah.panel
			,	m_adm_sekolah_fasilitas_sekolah_pemakaian_listrik.panel
			,	m_adm_sekolah_fasilitas_sekolah_buku_sekolah_dan_alat_pendidikan.panel
			,	m_adm_sekolah_fasilitas_sekolah_program_inklusi.panel
			]
	});
	
	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_fasilitas_sekolah_d +'data_ref_sekolah.jsp'
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					this.panel.setDisabled(true);
					return;
				}
				
				if (msg.inklusi == '0'){
					this.panel.getItem(6).setDisabled(true);
				}
			}
		,	scope	: this		
		});
	}
	
	this.do_refresh = function(ha_level)
	{
		m_adm_sekolah_fasilitas_sekolah_ha_level = ha_level;
		
		m_adm_sekolah_fasilitas_sekolah_properti_sekolah.do_refresh();
		m_adm_sekolah_fasilitas_sekolah_perlengkapan_sekolah.do_refresh();
		m_adm_sekolah_fasilitas_sekolah_perlengkapan_kbm.do_refresh();
		m_adm_sekolah_fasilitas_sekolah_ruangan_sekolah.do_refresh();
		m_adm_sekolah_fasilitas_sekolah_pemakaian_listrik.do_refresh();
		m_adm_sekolah_fasilitas_sekolah_buku_sekolah_dan_alat_pendidikan.do_refresh();
		m_adm_sekolah_fasilitas_sekolah_program_inklusi.do_refresh();
		
		this.do_check();
	}
}

m_adm_sekolah_fasilitas_sekolah = new M_AdmSekolahFasilitasSekolah();

//@ sourceURL=adm_sekolah_fasilitas_sekolah.layout.js
