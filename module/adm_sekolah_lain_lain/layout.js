/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_sekolah_lain_lain;
var m_adm_sekolah_lain_lain_kegiatan_sekolah;
var m_adm_sekolah_lain_lain_terancam_do;
var m_adm_sekolah_lain_lain_peringkat_do;
var m_adm_sekolah_lain_lain_perangkat_lunak;
var m_adm_sekolah_lain_lain_d = _g_root +'/module/adm_sekolah_lain_lain/';
var m_adm_sekolah_lain_lain_ha_level = 0;

function M_AdmSekolahLainLainKegiatanSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'no_kegiatan' }
		,	{ name	: 'no_kegiatan_old' }
		,	{ name	: 'nm_kegiatan' }
		,	{ name	: 'tanggal_mulai' }
		,	{ name	: 'tanggal_selesai' }
		,	{ name	: 'keterangan' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_lain_lain_d +'data_kegiatan_sekolah.jsp'
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_no_kegiatan = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_nm_kegiatan = new Ext.form.TextField({
		allowBlank	: false
	});

	this.form_tanggal_mulai = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_tanggal_selesai = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
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
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_kegiatan'
			, sortable		: true
			, editor		: this.form_no_kegiatan
			, align			: 'center'
			, width			: 70
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Nama Kegiatan'
			, dataIndex		: 'nm_kegiatan'
			, sortable		: true
			, editor		: this.form_nm_kegiatan
			, width			: 300
			, filterable	: true
			}
		,	{ header		: 'Tanggal Mulai'
			, dataIndex		: 'tanggal_mulai'
			, sortable		: true
			, editor		: this.form_tanggal_mulai
			, align			: 'center'
			, width			: 100
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'Tanggal Selesai'
			, dataIndex		: 'tanggal_selesai'
			, sortable		: true
			, editor		: this.form_tanggal_selesai
			, align			: 'center'
			, width			: 100
			, filter		: {
								type	: 'date'
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
					if (data.length && m_adm_sekolah_lain_lain_ha_level == 4) {
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
				no_kegiatan		: ''
			,	nm_kegiatan		: ''
			,	tanggal_mulai	: ''
			,	tanggal_selesai	: ''
			,	keterangan		: ''
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
						no_kegiatan		: record.data['no_kegiatan']
					,	no_kegiatan_old	: record.data['no_kegiatan_old']
					,	nm_kegiatan		: record.data['nm_kegiatan']
					,	tanggal_mulai	: record.data['tanggal_mulai']
					,	tanggal_selesai	: record.data['tanggal_selesai']
					,	keterangan		: record.data['keterangan']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_lain_lain_d +'submit_kegiatan_sekolah.jsp'
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
		if (m_adm_sekolah_lain_lain_ha_level >= 3) {
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
		if (m_adm_sekolah_lain_lain_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_lain_lain_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_lain_lain_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSekolahLainLainTerancamDO(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'jumlah' }
		,	{ name	: 'nm_tingkat_kelas' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_lain_lain_d +'data_terancam_do.jsp'
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_jumlah = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
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
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, readOnly		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Jumlah'
			, dataIndex		: 'jumlah'
			, sortable		: true
			, editor		: this.form_jumlah
			, align			: 'center'
			, width			: 100
			, filter		: {
					type	: 'numeric'
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
						kd_tingkat_kelas	: record.data['kd_tingkat_kelas']
					,	jumlah				: record.data['jumlah']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_sekolah_lain_lain_d +'submit_terancam_do.jsp'
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
		if (m_adm_sekolah_lain_lain_ha_level >= 3) {
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
		if (m_adm_sekolah_lain_lain_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahLainLainPeringkatDO(title)
{
	this.title			= title;
	this.dml_type		= 0;

	/* form items */
	this.form_lanjut_jauh = new Ext.form.NumberField({
			fieldLabel		: 'Lanjut Jauh'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_biaya = new Ext.form.NumberField({
			fieldLabel		: 'Biaya'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_transportasi = new Ext.form.NumberField({
			fieldLabel		: 'Transportasi'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_geografi = new Ext.form.NumberField({
			fieldLabel		: 'Geografi'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_terpencil = new Ext.form.NumberField({
			fieldLabel		: 'Terpencil'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_kurang_penting = new Ext.form.NumberField({
			fieldLabel		: 'Kurang Penting'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_kerja = new Ext.form.NumberField({
			fieldLabel		: 'Kerja'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_menikah = new Ext.form.NumberField({
			fieldLabel		: 'Menikah'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_lain_lain = new Ext.form.NumberField({
			fieldLabel		: 'Lain-Lain'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 9
		,	maxText			: 'Nilai Maksimal adalah 9'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_keterangan = new Ext.form.TextArea({
			fieldLabel		: 'Keterangan'
		,	width			: 300
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 150
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_lanjut_jauh
				,	this.form_biaya
				,	this.form_transportasi
				,	this.form_geografi
				,	this.form_terpencil
				,	this.form_kurang_penting
				,	this.form_kerja
				,	this.form_menikah
				,	this.form_lain_lain
				,	this.form_keterangan
			]
	});

	/* button */
	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_save	= new Ext.Button({
			text	: 'Simpan'
		,	iconCls	: 'save16'
		,	scope	: this
		,	handler	: function() {
				this.do_save();
			}
	});

	/* panel */
	this.panel = new Ext.Panel({
			title		: this.title
		,	autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: [
				this.btn_ref
			,	'->'
			,	this.btn_save
			]
		,	defaults	:{
				style		:{
					marginLeft		:'auto'
				,	marginRight		:'auto'
				,	marginBottom	:'8px'
				}
			}
		,	items		: [
				this.panel_form
			]
	});

	/* function */
	this.edit_fill_form = function(data)
	{
		this.form_lanjut_jauh.setValue(data.lanjut_jauh);
		this.form_biaya.setValue(data.biaya);
		this.form_transportasi.setValue(data.transportasi);
		this.form_geografi.setValue(data.geografi);
		this.form_terpencil.setValue(data.terpencil);
		this.form_kurang_penting.setValue(data.kurang_penting);
		this.form_kerja.setValue(data.kerja);
		this.form_menikah.setValue(data.menikah);
		this.form_lain_lain.setValue(data.lain_lain);
		this.form_keterangan.setValue(data.keterangan);
	}
	
	this.is_valid = function()
	{
		if (!this.form_lanjut_jauh.isValid()) {
			return false;
		}

		if (!this.form_biaya.isValid()) {
			return false;
		}

		if (!this.form_transportasi.isValid()) {
			return false;
		}

		if (!this.form_geografi.isValid()) {
			return false;
		}

		if (!this.form_terpencil.isValid()) {
			return false;
		}

		if (!this.form_kurang_penting.isValid()) {
			return false;
		}

		if (!this.form_kerja.isValid()) {
			return false;
		}

		if (!this.form_menikah.isValid()) {
			return false;
		}

		if (!this.form_lain_lain.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						lanjut_jauh		: this.form_lanjut_jauh.getValue()
					,	biaya			: this.form_biaya.getValue()
					,	transportasi	: this.form_transportasi.getValue()
					,	geografi		: this.form_geografi.getValue()
					,	terpencil		: this.form_terpencil.getValue()
					,	kurang_penting	: this.form_kurang_penting.getValue()
					,	kerja			: this.form_kerja.getValue()
					,	menikah			: this.form_menikah.getValue()
					,	lain_lain		: this.form_lain_lain.getValue()
					,	keterangan		: this.form_keterangan.getValue()
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_lain_lain_d +'submit_peringkat_do.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						Ext.MessageBox.alert('Informasi', msg.info);
						
						this.do_load();
					}
			,	scope	: this
		});
	}
	
	this.do_load = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_lain_lain_d +'data_peringkat_do.jsp'
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					this.dml_type	= 2;
					return;
				}
				
				this.edit_fill_form(msg);
				this.dml_type	= 3;
			}
		,	scope	: this		
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_lain_lain_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_lain_lain_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSekolahLainLainPerangkatLunak(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'nm_software' }
		,	{ name	: 'nm_software_old' }
		,	{ name	: 'jumlah_lisensi' }
		,	{ name	: 'jumlah_bajak' }
		,	{ name	: 'keterangan' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_lain_lain_d +'data_perangkat_lunak.jsp'
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_nm_software = new Ext.form.TextField({
		allowBlank	: false
	});

	this.form_jumlah_lisensi = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
	});

	this.form_jumlah_bajak = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
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
		,	{ header		: 'Nama Perangkat Lunak'
			, dataIndex		: 'nm_software'
			, sortable		: true
			, editor		: this.form_nm_software
			, width			: 300
			, filterable	: true
			}
		,	{ header		: 'Jumlah Lisensi'
			, dataIndex		: 'jumlah_lisensi'
			, sortable		: true
			, editor		: this.form_jumlah_lisensi
			, align			: 'center'
			, width			: 100
			, filter		: {
					type	: 'numeric'
			  }
			}
		,	{ header		: 'Jumlah Bajakan'
			, dataIndex		: 'jumlah_bajak'
			, sortable		: true
			, editor		: this.form_jumlah_bajak
			, align			: 'center'
			, width			: 100
			, filter		: {
					type	: 'numeric'
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
					if (data.length && m_adm_sekolah_lain_lain_ha_level == 4) {
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
				nm_software		: ''
			,	jumlah_lisensi	: ''
			,	jumlah_bajakan	: ''
			,	keterangan		: ''
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
						nm_software		: record.data['nm_software']
					,	nm_software_old	: record.data['nm_software_old']
					,	jumlah_lisensi	: record.data['jumlah_lisensi']
					,	jumlah_bajak	: record.data['jumlah_bajak']
					,	keterangan		: record.data['keterangan']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_lain_lain_d +'submit_perangkat_lunak.jsp'
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
		if (m_adm_sekolah_lain_lain_ha_level >= 3) {
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
		if (m_adm_sekolah_lain_lain_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_lain_lain_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_lain_lain_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSekolahLainLain()
{
	m_adm_sekolah_lain_lain_kegiatan_sekolah	= new M_AdmSekolahLainLainKegiatanSekolah('Kegiatan Sekolah');
	m_adm_sekolah_lain_lain_terancam_do			= new M_AdmSekolahLainLainTerancamDO('Terancam DO');
	m_adm_sekolah_lain_lain_peringkat_do		= new M_AdmSekolahLainLainPeringkatDO('Peringkat DO');
	m_adm_sekolah_lain_lain_perangkat_lunak		= new M_AdmSekolahLainLainPerangkatLunak('Perangkat Lunak');

	this.panel = new Ext.TabPanel({
			id				: 'adm_sekolah_lain_lain_panel'
		,	enableTabScroll	: true
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animScroll		: true
    		}
		,	items			: [
				m_adm_sekolah_lain_lain_kegiatan_sekolah.panel
			,	m_adm_sekolah_lain_lain_terancam_do.panel
			,	m_adm_sekolah_lain_lain_peringkat_do.panel
			,	m_adm_sekolah_lain_lain_perangkat_lunak.panel
			]
	});
	
	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_lain_lain_d +'data_ref_sekolah.jsp'
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
			}
		,	scope	: this		
		});
	}
	
	this.do_refresh = function(ha_level)
	{
		m_adm_sekolah_lain_lain_ha_level = ha_level;
		
		m_adm_sekolah_lain_lain_kegiatan_sekolah.do_refresh();
		m_adm_sekolah_lain_lain_terancam_do.do_refresh();
		m_adm_sekolah_lain_lain_peringkat_do.do_refresh();
		m_adm_sekolah_lain_lain_perangkat_lunak.do_refresh();
		
		this.do_check();
	}
}

m_adm_sekolah_lain_lain = new M_AdmSekolahLainLain();

//@ sourceURL=adm_sekolah_lain_lain.layout.js
