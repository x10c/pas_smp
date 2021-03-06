/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_pegawai_data_tenaga_administrasi;
var m_adm_pegawai_data_tenaga_administrasi_master_list;
var m_adm_pegawai_data_tenaga_administrasi_master_detail;
var m_adm_pegawai_data_tenaga_administrasi_detail_keluarga;
var m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_list;
var m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail;
var m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal;
var m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_list;
var m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail;
var m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_pangkat;
var m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_jabatan;
var m_adm_pegawai_data_tenaga_administrasi_detail_penataran;
var m_adm_pegawai_data_tenaga_administrasi_detail_penataran_list;
var m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail;
var m_adm_pegawai_data_tenaga_administrasi_id_pegawai = '';
var m_adm_pegawai_data_tenaga_administrasi_keluarga_no_urut = '';
var m_adm_pegawai_data_tenaga_administrasi_pendidikan_formal_no_urut = '';
var m_adm_pegawai_data_tenaga_administrasi_detail_penataran_no_urut = '';
var m_adm_pegawai_data_tenaga_administrasi_d = _g_root +'/module/adm_pegawai_data_tenaga_administrasi/';
var m_adm_pegawai_data_tenaga_administrasi_ha_level = 0;

function m_adm_pegawai_data_tenaga_administrasi_master_on_select_load_detail()
{
 	if (typeof m_adm_pegawai_data_tenaga_administrasi_master_list == 'undefined'
	||  typeof m_adm_pegawai_data_tenaga_administrasi_detail_keluarga == 'undefined'
	||  typeof m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal == 'undefined'
	||  typeof m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_pangkat == 'undefined'
	||  typeof m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_jabatan == 'undefined'
	||  typeof m_adm_pegawai_data_tenaga_administrasi_detail_penataran == 'undefined'
	||	m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
		return;
	}

	m_adm_pegawai_data_tenaga_administrasi_detail_keluarga.do_refresh();
	m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal.do_refresh();
	m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_pangkat.do_refresh();
	m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_jabatan.do_refresh();
	m_adm_pegawai_data_tenaga_administrasi_detail_penataran.do_refresh();
}

function M_AdmPegawaiDataTenagaAdministrasiDetailKeluargaDetail()
{
	this.dml_type	= 0;

	this.store_hubungan_keluarga = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['I','Istri']
			,	['S','Suami']
			,	['K','Anak Kandung']
			,	['T','Anak Tiri']
			,	['L','Lain-Lain']
			]
		,	idIndex		: 0
	});

	this.store_jenis_kelamin = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1','Laki-Laki']
			,	['2','Perempuan']
			]
		,	idIndex		: 0
	});

	this.store_agama = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_darah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_gol_darah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_nikah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['N','Menikah']
			,	['J','Janda']
			,	['D','Duda']
			,	['B','Belum Menikah']
			]
		,	idIndex		: 0
	});

	this.form_no_urut = new Ext.form.NumberField({
			fieldLabel		: 'No.Urut'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_nm_keluarga = new Ext.form.TextField({
			fieldLabel		: 'Nama Anggota Keluarga'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_hubungan_keluarga = new Ext.form.ComboBox({
			fieldLabel		: 'Hubungan Keluarga'
		,	store			: this.store_hubungan_keluarga
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jenis_kelamin = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Kelamin'
		,	store			: this.store_jenis_kelamin
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});
	
	this.form_prop_lahir = new Ext.form.TextField({
			fieldLabel		: 'Propinsi Tempat Lahir'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Kota Lahir'
		,	allowBlank		: false
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_agama = new Ext.form.ComboBox({
			fieldLabel		: 'Agama'
		,	store			: this.store_agama
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_gol_darah = new Ext.form.ComboBox({
			fieldLabel		: 'Gol.Darah'
		,	store			: this.store_gol_darah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_status_nikah = new Ext.form.ComboBox({
			fieldLabel		: 'Status Nikah'
		,	store			: this.store_status_nikah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_tanggal_menikah = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Menikah'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_tahun_meninggal = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Meninggal'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_alamat = new Ext.form.TextArea({
			fieldLabel		: 'Alamat'
		,	allowBlank		: true
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_no_urut
				,	this.form_nm_keluarga
				,	this.form_hubungan_keluarga
				,	this.form_jenis_kelamin
				,	this.form_prop_lahir
				,	this.form_kota_lahir
				,	this.form_tanggal_lahir
				,	this.form_agama
				,	this.form_gol_darah
				,	this.form_status_nikah
				,	this.form_tanggal_menikah
				,	this.form_tahun_meninggal
				,	this.form_alamat
			]
	});

	this.btn_back = new Ext.Button({
			text	: 'Kembali'
		,	iconCls	: 'back16'
		,	scope	: this
		,	handler	: function() {
				this.do_back();
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_back
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.Panel({
			autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: this.toolbar
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

	this.do_reset = function()
	{
		this.form_no_urut.setDisabled(false);
		
		this.form_no_urut.setValue('');
		this.form_nm_keluarga.setValue('');
		this.form_hubungan_keluarga.setValue('');
		this.form_jenis_kelamin.setValue('');
		this.form_prop_lahir.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_agama.setValue('');
		this.form_gol_darah.setValue('');
		this.form_status_nikah.setValue('');
		this.form_tanggal_menikah.setValue('');
		this.form_tahun_meninggal.setValue('');
		this.form_alamat.setValue('');
	}

	this.edit_fill_form = function(data)
	{
		this.form_no_urut.setValue(data.no_urut);
		this.form_nm_keluarga.setValue(data.nm_keluarga);
		this.form_hubungan_keluarga.setValue(data.kd_hub_keluarga);
		this.form_jenis_kelamin.setValue(data.kd_jenis_kelamin);
		this.form_prop_lahir.setValue(data.prop_lahir);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_agama.setValue(data.kd_agama);
		this.form_gol_darah.setValue(data.kd_gol_darah);
		this.form_status_nikah.setValue(data.kd_status_nikah);
		this.form_tanggal_menikah.setValue(data.tanggal_menikah);
		this.form_tahun_meninggal.setValue(data.tahun_meninggal);
		this.form_alamat.setValue(data.alamat);

		this.form_no_urut.setDisabled(true);
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_keluarga.jsp'
		,	params	: {
				id_pegawai		: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
			,	no_urut	: m_adm_pegawai_data_tenaga_administrasi_keluarga_no_urut
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.do_back = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(false);

		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(1);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(3);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(4);
		
		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga.panel.layout.setActiveItem(0);
	}

	this.is_valid = function()
	{
		if (!this.form_no_urut.isValid()) {
			return false;
		}

		if (!this.form_nm_keluarga.isValid()) {
			return false;
		}

		if (!this.form_hubungan_keluarga.isValid()) {
			return false;
		}

		if (!this.form_jenis_kelamin.isValid()) {
			return false;
		}

		if (!this.form_prop_lahir.isValid()) {
			return false;
		}

		if (!this.form_kota_lahir.isValid()) {
			return false;
		}

		if (!this.form_tanggal_lahir.isValid()) {
			return false;
		}

		if (!this.form_agama.isValid()) {
			return false;
		}

		if (!this.form_gol_darah.isValid()) {
			return false;
		}

		if (!this.form_status_nikah.isValid()) {
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

		main_load.show();
		
		Ext.Ajax.request({
				url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_keluarga.jsp'
			,	params  : {
						id_pegawai						: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
					,	no_urut					: this.form_no_urut.getValue()
					,	nm_keluarga				: this.form_nm_keluarga.getValue()
					,	kd_hub_keluarga			: this.form_hubungan_keluarga.getValue()
					,	kd_jenis_kelamin		: this.form_jenis_kelamin.getValue()
					,	prop_lahir				: this.form_prop_lahir.getValue()
					,	kota_lahir				: this.form_kota_lahir.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_agama				: this.form_agama.getValue()
					,	kd_gol_darah			: this.form_gol_darah.getValue()
					,	kd_status_nikah			: this.form_status_nikah.getValue()
					,	tanggal_menikah			: this.form_tanggal_menikah.getValue()
					,	tahun_meninggal			: this.form_tahun_meninggal.getValue()
					,	alamat					: this.form_alamat.getValue()
					,	dml_type				: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					main_load.hide();
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						main_load.hide();
						
						Ext.MessageBox.alert('Informasi', msg.info);

						m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(false);
						
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(1);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(2);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(3);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(4);

						m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_list.store.reload();
						m_adm_pegawai_data_tenaga_administrasi_detail_keluarga.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_agama.load();
		this.store_gol_darah.load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailKeluargaList()
{
	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'nm_keluarga' }
		,	{ name	: 'kd_hub_keluarga' }
		,	{ name	: 'alamat' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_keluarga_list.jsp'
		,	autoLoad	: false
	});

	this.store_hubungan_keluarga = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['I','Istri']
			,	['S','Suami']
			,	['K','Anak Kandung']
			,	['T','Anak Tiri']
			,	['L','Lain-Lain']
			]
		,	idIndex		: 0
	});
	
	/* form items */
	this.form_hubungan_keluarga = new Ext.form.ComboBox({
			store			: this.store_hubungan_keluarga
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
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
	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_urut'
			, align			: 'center'
			, width			: 70
			, filterable	: true
			}
		,	{ header		: 'Nama Anggota Keluarga'
			, dataIndex		: 'nm_keluarga'
			, width			: 250
			, filterable	: true
			}
		,	{ header		: 'Hubungan Keluarga'
			, dataIndex		: 'kd_hub_keluarga'
			, editor		: this.form_hubungan_keluarga
			, renderer		: combo_renderer(this.form_hubungan_keluarga)
			, align			: 'center'
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_hubungan_keluarga
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'alamat'
			, header		: 'Alamat'
			, dataIndex		: 'alamat'
			, filterable	: true
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_adm_pegawai_data_tenaga_administrasi_keluarga_no_urut = data[0].data['no_urut'];
						
						if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
					} else {
						m_adm_pegawai_data_tenaga_administrasi_keluarga_no_urut = '';
						this.btn_del.setDisabled(true);
					}
				}
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

	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
				this.do_edit();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'alamat'
	});

	this.do_del = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				Ext.Ajax.request({
					url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_keluarga.jsp'
				,	params	: {
						dml_type			: 4
					,	id_pegawai					: data.get('id_pegawai')
					,	no_urut				: data.get('no_urut')
					,	nm_keluarga			: ''
					, 	kd_hub_keluarga		: ''
					, 	kd_jenis_kelamin	: ''
					, 	prop_lahir			: ''
					, 	kota_lahir			: ''
					, 	tanggal_lahir		: ''
					, 	kd_agama			: ''
					, 	kd_gol_darah		: ''
					, 	kd_status_nikah		: ''
					, 	tanggal_menikah		: ''
					, 	tahun_meninggal		: ''
					, 	alamat				: ''
					}
				,	waitMsg	: 'Mohon Tunggu ...'
				,	failure	: function(response) {
						Ext.MessageBox.alert('Gagal', response.responseText);
					}
				,	success : function (response) {
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Kesalahan', msg.info);
							return;
						}

						Ext.MessageBox.alert('Informasi', msg.info);

						this.do_load();
					}
				,	scope	: this
				});
			}
		}, this);
	}

	this.do_edit = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail.do_edit(data.get('no_urut'));
		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga.panel.layout.setActiveItem(1);
		
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(true);

		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(1);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(3);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(4);
	}

	this.do_add = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail.do_add();
		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga.panel.layout.setActiveItem(1);
		
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(true);

		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(1);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(3);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(4);
	}
	
	this.do_load = function()
	{
		this.store.load({
			params	: {
				id_pegawai		: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailKeluarga(title)
{
	m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_list		= new M_AdmPegawaiDataTenagaAdministrasiDetailKeluargaList();
	m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail	= new M_AdmPegawaiDataTenagaAdministrasiDetailKeluargaDetail();
	
	this.panel = new Ext.Panel({
			title			: title
		,	region			: 'center'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_list.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_detail.panel
			]
	});
	
	this.do_refresh = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_detail_keluarga_list.do_refresh();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailPendidikanFormalDetail()
{
	this.dml_type	= 0;

	this.store_tingkat_ijazah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_tingkat_ijazah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_program_studi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_program_studi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_akreditasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_akreditasi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_lulus = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Tidak Lulus']
			,	['1','Lulus']
			]
		,	idIndex		: 0
	});

	this.form_no_urut = new Ext.form.NumberField({
			fieldLabel		: 'No.Urut'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_tingkat_ijazah = new Ext.form.ComboBox({
			fieldLabel		: 'Tingkat Ijazah'
		,	store			: this.store_tingkat_ijazah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_nm_instansi_penddkn = new Ext.form.TextField({
			fieldLabel		: 'Nama Instansi Pendidikan'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_program_studi = new Ext.form.ComboBox({
			fieldLabel		: 'Program Studi'
		,	store			: this.store_program_studi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_akreditasi = new Ext.form.ComboBox({
			fieldLabel		: 'Akreditasi'
		,	store			: this.store_akreditasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_tahun_mulai = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Mulai'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_status_lulus = new Ext.form.ComboBox({
			fieldLabel		: 'Status Lulus'
		,	store			: this.store_status_lulus
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_tahun_selesai = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Selesai'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_no_ijazah = new Ext.form.TextField({
			fieldLabel		: 'Nomor Ijazah'
		,	allowBlank		: true
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_tanggal_ijazah = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Ijazah'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: true
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_no_urut
				,	this.form_tingkat_ijazah
				,	this.form_nm_instansi_penddkn
				,	this.form_program_studi
				,	this.form_akreditasi
				,	this.form_tahun_mulai
				,	this.form_status_lulus
				,	this.form_tahun_selesai
				,	this.form_no_ijazah
				,	this.form_tanggal_ijazah
			]
	});

	this.btn_back = new Ext.Button({
			text	: 'Kembali'
		,	iconCls	: 'back16'
		,	scope	: this
		,	handler	: function() {
				this.do_back();
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_back
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.Panel({
			autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: this.toolbar
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

	this.do_reset = function()
	{
		this.form_no_urut.setDisabled(false);
		
		this.form_no_urut.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_nm_instansi_penddkn.setValue('');
		this.form_program_studi.setValue('');
		this.form_akreditasi.setValue('');
		this.form_tahun_mulai.setValue('');
		this.form_status_lulus.setValue('');
		this.form_tahun_selesai.setValue('');
		this.form_no_ijazah.setValue('');
		this.form_tanggal_ijazah.setValue('');
	}

	this.edit_fill_form = function(data)
	{
		this.form_no_urut.setValue(data.no_urut);
		this.form_tingkat_ijazah.setValue(data.kd_tingkat_ijazah);
		this.form_nm_instansi_penddkn.setValue(data.nm_instansi_penddkn);
		this.form_program_studi.setValue(data.kd_program_studi);
		this.form_akreditasi.setValue(data.kd_akreditasi);
		this.form_tahun_mulai.setValue(data.tahun_mulai);
		this.form_status_lulus.setValue(data.kd_status_lulus);
		this.form_tahun_selesai.setValue(data.tahun_selesai);
		this.form_no_ijazah.setValue(data.no_ijazah);
		this.form_tanggal_ijazah.setValue(data.tanggal_ijazah);

		this.form_no_urut.setDisabled(true);
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_pendidikan_formal.jsp'
		,	params	: {
				id_pegawai		: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
			,	no_urut	: m_adm_pegawai_data_tenaga_administrasi_pendidikan_formal_no_urut
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.do_back = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(false);
		
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(0);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(3);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(4);

		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal.panel.layout.setActiveItem(0);		
	}

	this.is_valid = function()
	{
		if (!this.form_no_urut.isValid()) {
			return false;
		}

		if (!this.form_tingkat_ijazah.isValid()) {
			return false;
		}

		if (!this.form_nm_instansi_penddkn.isValid()) {
			return false;
		}

		if (!this.form_program_studi.isValid()) {
			return false;
		}

		if (!this.form_akreditasi.isValid()) {
			return false;
		}

		if (!this.form_tahun_mulai.isValid()) {
			return false;
		}

		if (!this.form_status_lulus.isValid()) {
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

		main_load.show();
		
		Ext.Ajax.request({
				url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_pendidikan_formal.jsp'
			,	params  : {
						id_pegawai						: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
					,	no_urut					: this.form_no_urut.getValue()
					,	kd_tingkat_ijazah		: this.form_tingkat_ijazah.getValue()
					,	nm_instansi_penddkn		: this.form_nm_instansi_penddkn.getValue()
					,	kd_program_studi		: this.form_program_studi.getValue()
					,	kd_akreditasi			: this.form_akreditasi.getValue()
					,	tahun_mulai				: this.form_tahun_mulai.getValue()
					,	kd_status_lulus			: this.form_status_lulus.getValue()
					,	tahun_selesai			: this.form_tahun_selesai.getValue()
					,	no_ijazah				: this.form_no_ijazah.getValue()
					,	tanggal_ijazah			: this.form_tanggal_ijazah.getValue()
					,	dml_type				: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					main_load.hide();
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						main_load.hide();
						
						Ext.MessageBox.alert('Informasi', msg.info);

						m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(false);
						
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(0);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(2);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(3);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(4);

						m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_list.store.reload();
						m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_tingkat_ijazah.load();
		this.store_program_studi.load();
		this.store_akreditasi.load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailPendidikanFormalList()
{
	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'kd_tingkat_ijazah' }
		,	{ name	: 'nm_instansi_penddkn' }
		,	{ name	: 'kd_program_studi' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_pendidikan_formal_list.jsp'
		,	autoLoad	: false
	});

	this.store_tingkat_ijazah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d + 'data_ref_tingkat_ijazah.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	this.store_program_studi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d + 'data_ref_program_studi.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});
	
	/* form items */
	this.form_tingkat_ijazah = new Ext.form.ComboBox({
			store			: this.store_tingkat_ijazah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_program_studi = new Ext.form.ComboBox({
			store			: this.store_program_studi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
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
	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_urut'
			, align			: 'center'
			, width			: 70
			, filterable	: true
			}
		,	{ header		: 'Tingkat Ijazah'
			, dataIndex		: 'kd_tingkat_ijazah'
			, editor		: this.form_tingkat_ijazah
			, renderer		: combo_renderer(this.form_tingkat_ijazah)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_tingkat_ijazah
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'nm_instansi_penddkn'
			, header		: 'Nama Instansi Pendidikan'
			, dataIndex		: 'nm_instansi_penddkn'
			, filterable	: true
			}
		,	{ header		: 'Program Studi'
			, dataIndex		: 'kd_program_studi'
			, editor		: this.form_program_studi
			, renderer		: combo_renderer(this.form_program_studi)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_program_studi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_adm_pegawai_data_tenaga_administrasi_pendidikan_formal_no_urut = data[0].data['no_urut'];
						
						if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
					} else {
						m_adm_pegawai_data_tenaga_administrasi_pendidikan_formal_no_urut = '';
						this.btn_del.setDisabled(true);
					}
				}
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

	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
				this.do_edit();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nm_instansi_penddkn'
	});

	this.do_del = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				Ext.Ajax.request({
					url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_pendidikan_formal.jsp'
				,	params	: {
						dml_type			: 4
					,	id_pegawai					: data.get('id_pegawai')
					,	no_urut				: data.get('no_urut')
					,	kd_tingkat_ijazah	: ''
					, 	nm_instansi_penddkn	: ''
					, 	kd_program_studi	: ''
					, 	kd_akreditasi		: ''
					, 	tahun_mulai			: ''
					, 	kd_status_lulus		: ''
					, 	tahun_selesai		: ''
					, 	no_ijazah			: ''
					, 	tanggal_ijazah		: ''
					}
				,	waitMsg	: 'Mohon Tunggu ...'
				,	failure	: function(response) {
						Ext.MessageBox.alert('Gagal', response.responseText);
					}
				,	success : function (response) {
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Kesalahan', msg.info);
							return;
						}

						Ext.MessageBox.alert('Informasi', msg.info);

						this.do_load();
					}
				,	scope	: this
				});
			}
		}, this);
	}

	this.do_edit = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail.do_edit(data.get('no_urut'));
		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal.panel.layout.setActiveItem(1);
		
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(true);

		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(0);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(3);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(4);
	}

	this.do_add = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail.do_add();
		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal.panel.layout.setActiveItem(1);
		
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(true);
		
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(0);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(3);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(4);
	}
	
	this.do_load = function()
	{
		this.store_tingkat_ijazah.load({
			callback	: function(){
				this.store_program_studi.load({
					callback	: function(){
						this.store.load({
							params	: {
								id_pegawai		: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
							}
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
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailPendidikanFormal(title)
{
	m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_list	= new M_AdmPegawaiDataTenagaAdministrasiDetailPendidikanFormalList();
	m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail	= new M_AdmPegawaiDataTenagaAdministrasiDetailPendidikanFormalDetail();
	
	this.panel = new Ext.Panel({
			title			: title
		,	region			: 'center'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_list.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_detail.panel
			]
	});
	
	this.do_refresh = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal_list.do_refresh();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailRiwayatPangkat(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'no_sk' }
		,	{ name	: 'tanggal_sk' }
		,	{ name	: 'tmt_sk' }
		,	{ name	: 'kd_status_pegawai' }
		,	{ name	: 'kd_pangkat' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_riwayat_pangkat.jsp'
		,	autoLoad	: false
	});
	
	this.store_status_pegawai = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_status_pegawai.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_pangkat = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_pangkat.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_no_urut = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_no_sk = new Ext.form.TextField({
			allowBlank		: false
	});

	this.form_tanggal_sk = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_tmt_sk = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_status_pegawai = new Ext.form.ComboBox({
			store			: this.store_status_pegawai
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_pangkat = new Ext.form.ComboBox({
			store			: this.store_pangkat
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
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
			, dataIndex		: 'no_urut'
			, sortable		: true
			, editor		: this.form_no_urut
			, align			: 'center'
			, width			: 60
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Nomor SK'
			, dataIndex		: 'no_sk'
			, sortable		: true
			, editor		: this.form_no_sk
			, width			: 130
			, filterable	: true
			}
		,	{ header		: 'Tanggal SK'
			, dataIndex		: 'tanggal_sk'
			, sortable		: true
			, editor		: this.form_tanggal_sk
			, align			: 'center'
			, width			: 100
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'TMT SK'
			, dataIndex		: 'tmt_sk'
			, sortable		: true
			, editor		: this.form_tmt_sk
			, align			: 'center'
			, width			: 100
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'Status Pegawai'
			, dataIndex		: 'kd_status_pegawai'
			, sortable		: true
			, editor		: this.form_status_pegawai
			, renderer		: combo_renderer(this.form_status_pegawai)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_status_pegawai
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Pangkat'
			, dataIndex		: 'kd_pangkat'
			, sortable		: true
			, editor		: this.form_pangkat
			, renderer		: combo_renderer(this.form_pangkat)
			, width			: 100
			, filter		: {
					type		: 'list'
				,	store		: this.store_pangkat
				,	labelField	: 'name'
				,	phpMode		: false
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
					if (data.length && m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
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
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
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
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pegawai					: ''
			,	no_urut				: ''
			,	no_sk				: ''
			,	tanggal_sk			: ''
			,	tmt_sk				: ''
			,	kd_status_pegawai	: ''
			,	kd_pangkat			: ''
			,	keterangan			: ''
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
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
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
		
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_pegawai			: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
					,	no_urut				: record.data['no_urut']
					,	no_urut_old			: record.data['no_urut_old']
					,	no_sk				: record.data['no_sk']
					,	tanggal_sk			: record.data['tanggal_sk']
					,	tmt_sk				: record.data['tmt_sk']
					,	kd_status_pegawai	: record.data['kd_status_pegawai']
					,	kd_pangkat			: record.data['kd_pangkat']
					,	keterangan			: record.data['keterangan']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_riwayat_pangkat.jsp'
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
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}
	
	this.do_load = function()
	{
		this.store_status_pegawai.load({
			callback	: function(){
				this.store_pangkat.load({
					callback	: function(){
						this.store.load({
							params	: {
								id_pegawai	: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
							}
						});
					}
				,	scope		: this
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailRiwayatJabatan(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'no_sk' }
		,	{ name	: 'tanggal_sk' }
		,	{ name	: 'tmt_sk' }
		,	{ name	: 'kd_jenis_pegawai' }
		,	{ name	: 'kd_tenaga_administrasi' }
		,	{ name	: 'tahun_berhenti' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_riwayat_jabatan.jsp'
		,	autoLoad	: false
	});
	
	this.store_jenis_pegawai = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_jenis_pegawai.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_tenaga_administrasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_tenaga_administrasi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_no_urut = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_no_sk = new Ext.form.TextField({
			allowBlank		: false
	});

	this.form_tanggal_sk = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_tmt_sk = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_jenis_pegawai = new Ext.form.ComboBox({
			store			: this.store_jenis_pegawai
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 400
	});

	this.form_tenaga_administrasi = new Ext.form.ComboBox({
			store			: this.store_tenaga_administrasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 300
	});

	this.form_tahun_berhenti = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Berhenti'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom adalah 4'
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
			, dataIndex		: 'no_urut'
			, sortable		: true
			, editor		: this.form_no_urut
			, align			: 'center'
			, width			: 60
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Nomor SK'
			, dataIndex		: 'no_sk'
			, sortable		: true
			, editor		: this.form_no_sk
			, width			: 130
			, filterable	: true
			}
		,	{ header		: 'Tanggal SK'
			, dataIndex		: 'tanggal_sk'
			, sortable		: true
			, editor		: this.form_tanggal_sk
			, align			: 'center'
			, width			: 90
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'TMT SK'
			, dataIndex		: 'tmt_sk'
			, sortable		: true
			, editor		: this.form_tmt_sk
			, align			: 'center'
			, width			: 90
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'Jabatan Pegawai'
			, dataIndex		: 'kd_jenis_pegawai'
			, sortable		: true
			, editor		: this.form_jenis_pegawai
			, renderer		: combo_renderer(this.form_jenis_pegawai)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_jenis_pegawai
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Jenis Ketenagaan'
			, dataIndex		: 'kd_tenaga_administrasi'
			, sortable		: true
			, editor		: this.form_tenaga_administrasi
			, renderer		: combo_renderer(this.form_tenaga_administrasi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_tenaga_administrasi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tahun Berhenti'
			, dataIndex		: 'tahun_berhenti'
			, sortable		: true
			, editor		: this.form_tahun_berhenti
			, align			: 'center'
			, width			: 90
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
					if (data.length && m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
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
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
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
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_pegawai						: ''
			,	no_urut					: ''
			,	no_sk					: ''
			,	tanggal_sk				: ''
			,	tmt_sk					: ''
			,	kd_jenis_pegawai		: ''
			,	kd_tenaga_adminitrasi	: ''
			,	tahun_berhenti			: ''
			,	keterangan				: ''
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
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
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
		
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_pegawai						: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
					,	no_urut					: record.data['no_urut']
					,	no_urut_old				: record.data['no_urut_old']
					,	no_sk					: record.data['no_sk']
					,	tanggal_sk				: record.data['tanggal_sk']
					,	tmt_sk					: record.data['tmt_sk']
					,	kd_jenis_pegawai		: record.data['kd_jenis_pegawai']
					,	kd_tenaga_administrasi	: record.data['kd_tenaga_administrasi']
					,	tahun_berhenti			: record.data['tahun_berhenti']
					,	keterangan				: record.data['keterangan']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_riwayat_jabatan.jsp'
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
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_jenis_pegawai.load({
			callback	: function(){
				this.store_tenaga_administrasi.load({
					callback	: function(){
						this.store.load({
							params	: {
								id_pegawai	: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
							}
						});
					}
				,	scope		: this
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailPenataranDetail()
{
	this.dml_type	= 0;

	this.store_penataran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_penataran.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_penyelenggara_penataran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_penyelenggara_penataran.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_jenis_penataran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_jenis_penataran.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_jenis_peserta_penataran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_jenis_peserta_penataran.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_no_urut = new Ext.form.NumberField({
			fieldLabel		: 'No.Urut'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_penataran = new Ext.form.ComboBox({
			fieldLabel		: 'Nama Penataran'
		,	store			: this.store_penataran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_penyelenggara_penataran = new Ext.form.ComboBox({
			fieldLabel		: 'Penyelenggara Penataran'
		,	store			: this.store_penyelenggara_penataran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jenis_penataran = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Penataran'
		,	store			: this.store_jenis_penataran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jenis_peserta_penataran = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Peserta Penataran'
		,	store			: this.store_jenis_peserta_penataran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_tanggal_awal = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Awal'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: true
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_tanggal_akhir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Akhir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: true
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jam = new Ext.form.NumberField({
			fieldLabel		: 'Lama (Jam)'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_no_urut
				,	this.form_penataran
				,	this.form_penyelenggara_penataran
				,	this.form_jenis_penataran
				,	this.form_jenis_peserta_penataran
				,	this.form_tanggal_awal
				,	this.form_tanggal_akhir
				,	this.form_jam
			]
	});

	this.btn_back = new Ext.Button({
			text	: 'Kembali'
		,	iconCls	: 'back16'
		,	scope	: this
		,	handler	: function() {
				this.do_back();
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_back
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.Panel({
			autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: this.toolbar
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

	this.do_reset = function()
	{
		this.form_no_urut.setDisabled(false);
		
		this.form_no_urut.setValue('');
		this.form_penataran.setValue('');
		this.form_penyelenggara_penataran.setValue('');
		this.form_jenis_penataran.setValue('');
		this.form_jenis_peserta_penataran.setValue('');
		this.form_tanggal_awal.setValue('');
		this.form_tanggal_akhir.setValue('');
		this.form_jam.setValue('');
	}

	this.edit_fill_form = function(data)
	{
		this.form_no_urut.setValue(data.no_urut);
		this.form_penataran.setValue(data.id_penataran);
		this.form_penyelenggara_penataran.setValue(data.kd_penyelenggara_penataran);
		this.form_jenis_penataran.setValue(data.kd_jenis_penataran);
		this.form_jenis_peserta_penataran.setValue(data.kd_jenis_peserta_penataran);
		this.form_tanggal_awal.setValue(data.tanggal_awal);
		this.form_tanggal_akhir.setValue(data.tanggal_akhir);
		this.form_jam.setValue(data.jam);

		this.form_no_urut.setDisabled(true);
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_penataran.jsp'
		,	params	: {
				id_pegawai		: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
			,	no_urut	: m_adm_pegawai_data_tenaga_administrasi_penataran_no_urut
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.do_back = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(false);
		
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(0);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(1);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(3);

		m_adm_pegawai_data_tenaga_administrasi_detail_penataran.panel.layout.setActiveItem(0);		
	}

	this.is_valid = function()
	{
		if (!this.form_no_urut.isValid()) {
			return false;
		}

		if (!this.form_penataran.isValid()) {
			return false;
		}

		if (!this.form_penyelenggara_penataran.isValid()) {
			return false;
		}

		if (!this.form_jenis_penataran.isValid()) {
			return false;
		}

		if (!this.form_jenis_peserta_penataran.isValid()) {
			return false;
		}

		if (!this.form_jam.isValid()) {
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

		main_load.show();
		
		Ext.Ajax.request({
				url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_penataran.jsp'
			,	params  : {
						id_pegawai							: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
					,	no_urut						: this.form_no_urut.getValue()
					,	id_penataran				: this.form_penataran.getValue()
					,	kd_penyelenggara_penataran	: this.form_penyelenggara_penataran.getValue()
					,	kd_jenis_penataran			: this.form_jenis_penataran.getValue()
					,	kd_jenis_peserta_penataran	: this.form_jenis_peserta_penataran.getValue()
					,	tanggal_awal				: this.form_tanggal_awal.getValue()
					,	tanggal_akhir				: this.form_tanggal_akhir.getValue()
					,	jam							: this.form_jam.getValue()
					,	dml_type					: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					main_load.hide();
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						main_load.hide();
						
						Ext.MessageBox.alert('Informasi', msg.info);

						m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(false);
						
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(0);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(1);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(2);
						m_adm_pegawai_data_tenaga_administrasi.panel_detail.unhideTabStripItem(3);

						m_adm_pegawai_data_tenaga_administrasi_detail_penataran_list.store.reload();
						m_adm_pegawai_data_tenaga_administrasi_detail_penataran.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_penataran.load();
		this.store_penyelenggara_penataran.load();
		this.store_jenis_penataran.load();
		this.store_jenis_peserta_penataran.load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailPenataranList()
{
	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'id_penataran' }
		,	{ name	: 'kd_jenis_peserta_penataran' }
		,	{ name	: 'jam' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_detail_penataran_list.jsp'
		,	autoLoad	: false
	});

	this.store_penataran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d + 'data_ref_penataran.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	this.store_jenis_peserta_penataran = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d + 'data_ref_jenis_peserta_penataran.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});
	
	/* form items */
	this.form_penataran = new Ext.form.ComboBox({
			store			: this.store_penataran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_jenis_peserta_penataran = new Ext.form.ComboBox({
			store			: this.store_jenis_peserta_penataran
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
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
	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_urut'
			, align			: 'center'
			, width			: 70
			, filterable	: true
			}
		,	{ id			: 'id_penataran'
			, header		: 'Nama Penataran'
			, dataIndex		: 'id_penataran'
			, editor		: this.form_penataran
			, renderer		: combo_renderer(this.form_penataran)
			, filter		: {
					type		: 'list'
				,	store		: this.store_penataran
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Jenis Peserta Penataran'
			, dataIndex		: 'kd_jenis_peserta_penataran'
			, editor		: this.form_jenis_peserta_penataran
			, renderer		: combo_renderer(this.form_jenis_peserta_penataran)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_jenis_peserta_penataran
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Lama (Jam)'
			, dataIndex		: 'jam'
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_adm_pegawai_data_tenaga_administrasi_penataran_no_urut = data[0].data['no_urut'];
						
						if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
					} else {
						m_adm_pegawai_data_tenaga_administrasi_penataran_no_urut = '';
						this.btn_del.setDisabled(true);
					}
				}
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

	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
				this.do_edit();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_edit
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			region				: 'center'
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'id_penataran'
	});

	this.do_del = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				Ext.Ajax.request({
					url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_detail_penataran.jsp'
				,	params	: {
						dml_type					: 4
					,	id_pegawai							: data.get('id_pegawai')
					,	no_urut						: data.get('no_urut')
					,	id_penataran				: ''
					, 	kd_penyelenggara_penataran	: ''
					, 	kd_jenis_penataran			: ''
					, 	kd_jenis_peserta_penataran	: ''
					, 	kd_mata_pelajaran_diajarkan	: ''
					, 	tanggal_awal				: ''
					, 	tanggal_akhir				: ''
					, 	jam							: ''
					}
				,	waitMsg	: 'Mohon Tunggu ...'
				,	failure	: function(response) {
						Ext.MessageBox.alert('Gagal', response.responseText);
					}
				,	success : function (response) {
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Kesalahan', msg.info);
							return;
						}

						Ext.MessageBox.alert('Informasi', msg.info);

						this.do_load();
					}
				,	scope	: this
				});
			}
		}, this);
	}

	this.do_edit = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail.do_edit(data.get('no_urut'));
		m_adm_pegawai_data_tenaga_administrasi_detail_penataran.panel.layout.setActiveItem(1);
		
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(true);

		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(0);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(1);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(3);
	}

	this.do_add = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_id_pegawai == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tenaga Administrasi terlebih dahulu!");
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail.do_add();
		m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_detail_penataran.panel.layout.setActiveItem(1);
		
		m_adm_pegawai_data_tenaga_administrasi_master.panel.setDisabled(true);
		
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(0);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(1);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(2);
		m_adm_pegawai_data_tenaga_administrasi.panel_detail.hideTabStripItem(3);
	}
	
	this.do_load = function()
	{
		this.store_penataran.load({
			callback	: function(){
				this.store_jenis_peserta_penataran.load({
					callback	: function(){
						this.store.load({
							params	: {
								id_pegawai		: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
							}
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
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiDetailPenataran(title)
{
	m_adm_pegawai_data_tenaga_administrasi_detail_penataran_list	= new M_AdmPegawaiDataTenagaAdministrasiDetailPenataranList();
	m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail	= new M_AdmPegawaiDataTenagaAdministrasiDetailPenataranDetail();
	
	this.panel = new Ext.Panel({
			title			: title
		,	region			: 'center'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				m_adm_pegawai_data_tenaga_administrasi_detail_penataran_list.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_penataran_detail.panel
			]
	});
	
	this.do_refresh = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_detail_penataran_list.do_refresh();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiMasterDetail(title)
{
	this.dml_type	= 0;

	this.store_jenis_kelamin = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['1','Laki-Laki']
			,	['2','Perempuan']
			]
		,	idIndex		: 0
	});

	this.store_agama = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_agama.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_darah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_ref_gol_darah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_status_nikah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['N','Menikah']
			,	['J','Janda']
			,	['D','Duda']
			,	['B','Belum Menikah']
			]
		,	idIndex		: 0
	});

	this.store_operasi_komputer = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Belum Mampu Mengoperasikan']
			,	['1','Sudah Mampu Mengoperasikan']
			]
		,	idIndex		: 0
	});

	this.store_kursus_komputer = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Belum Pernah']
			,	['1','Pernah']
			]
		,	idIndex		: 0
	});

	this.store_sertifikasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	data		: [
				['0','Sudah']
			,	['1','Belum']
			]
		,	idIndex		: 0
	});

	this.form_nip = new Ext.form.NumberField({
			fieldLabel		: 'NIP'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 18
		,	maxLengthText	: 'Maksimal panjang kolom adalah 18'
		,	width			: 150
		,	msgTarget		: 'side'
		,	listeners		: {
				change	: function(form, newvalue, oldvalue) {
					this.foto.el.dom.src = _g_root + '/images/foto_guru/' + newvalue + '.jpg';
				}
			,	scope	: this
			}
	});

	this.form_nuptk = new Ext.form.NumberField({
			fieldLabel		: 'NUPTK'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 16
		,	maxLengthText	: 'Maksimal panjang kolom adalah 16'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_nm_pegawai = new Ext.form.TextField({
			fieldLabel		: 'Nama Tenaga Administrasi'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_inisial = new Ext.form.TextField({
			fieldLabel		: 'Inisial'
		,	allowBlank		: false
		,	maxLength		: 3
		,	maxLengthText	: 'Maksimal panjang kolom adalah 3'
		,	width			: 30
		,	msgTarget		: 'side'
	});

	this.form_kota_lahir = new Ext.form.TextField({
			fieldLabel		: 'Kota Lahir'
		,	allowBlank		: false
		,	width			: 250
		,	msgTarget		: 'side'
	});

	this.form_tanggal_lahir = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Lahir'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_jenis_kelamin = new Ext.form.ComboBox({
			fieldLabel		: 'Jenis Kelamin'
		,	store			: this.store_jenis_kelamin
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_agama = new Ext.form.ComboBox({
			fieldLabel		: 'Agama'
		,	store			: this.store_agama
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_alamat = new Ext.form.TextArea({
			fieldLabel		: 'Alamat'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_kode_pos = new Ext.form.NumberField({
			fieldLabel		: 'Kode Pos'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom adalah 5'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_gol_darah = new Ext.form.ComboBox({
			fieldLabel		: 'Gol.Darah'
		,	store			: this.store_gol_darah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_no_telp = new Ext.form.NumberField({
			fieldLabel		: 'No.Telepon'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom adalah 30'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_no_hp = new Ext.form.NumberField({
			fieldLabel		: 'No.HP'
		,	allowBlank		: true
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 30
		,	maxLengthText	: 'Maksimal panjang kolom adalah 30'
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_status_nikah = new Ext.form.ComboBox({
			fieldLabel		: 'Status Nikah'
		,	store			: this.store_status_nikah
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_operasi_komputer = new Ext.form.ComboBox({
			fieldLabel		: 'Operasi Komputer'
		,	store			: this.store_operasi_komputer
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_kursus_komputer = new Ext.form.ComboBox({
			fieldLabel		: 'Kursus Komputer'
		,	store			: this.store_kursus_komputer
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_sertifikasi = new Ext.form.ComboBox({
			fieldLabel		: 'Sertifikasi'
		,	store			: this.store_sertifikasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: true
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.foto = new Ext.BoxComponent({
		anchor		: ''
	,	fieldLabel	: 'Foto (130px X 170px)'
	,	isFormField	: true
	,	height		: 170
	,	width		: 130
	,	autoEl		: {
			tag	: 'img'
		,	src	: _g_root + '/images/foto_guru/default.gif'
		}
	});

	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 175
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_nip
				,	this.foto
				,	this.form_nuptk
				,	this.form_nm_pegawai
				,	this.form_inisial
				,	this.form_kota_lahir
				,	this.form_tanggal_lahir
				,	this.form_jenis_kelamin
				,	this.form_agama
				,	this.form_alamat
				,	this.form_kode_pos
				,	this.form_gol_darah
				,	this.form_no_telp
				,	this.form_no_hp
				,	this.form_status_nikah
				,	this.form_operasi_komputer
				,	this.form_kursus_komputer
				,	this.form_sertifikasi
			]
	});

	this.btn_back = new Ext.Button({
			text	: 'Kembali'
		,	iconCls	: 'back16'
		,	scope	: this
		,	handler	: function() {
				this.do_back();
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_back
		,	'->'
		,	this.btn_save
		]
	});

	this.panel = new Ext.Panel({
			title		: title
		,	autoWidth	: true
		,	autoScroll	: true
		,	padding		:'6'
		,	tbar		: this.toolbar
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

	this.do_reset = function()
	{
		this.form_nip.setValue('');
		this.form_nuptk.setValue('');
		this.form_nm_pegawai.setValue('');
		this.form_inisial.setValue('');
		this.form_kota_lahir.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_jenis_kelamin.setValue('');
		this.form_agama.setValue('');
		this.form_alamat.setValue('');
		this.form_kode_pos.setValue('');
		this.form_gol_darah.setValue('');
		this.form_no_telp.setValue('');
		this.form_no_hp.setValue('');
		this.form_status_nikah.setValue('');
		this.form_operasi_komputer.setValue('');
		this.form_kursus_komputer.setValue('');
		this.form_sertifikasi.setValue('');
		
		this.foto.el.dom.src = _g_root + '/images/foto_guru/default.gif'
	}

	this.edit_fill_form = function(data)
	{
		this.form_nip.setValue(data.nip);
		this.form_nuptk.setValue(data.nuptk);
		this.form_nm_pegawai.setValue(data.nm_pegawai);
		this.form_inisial.setValue(data.inisial);
		this.form_kota_lahir.setValue(data.kota_lahir);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_jenis_kelamin.setValue(data.kd_jenis_kelamin);
		this.form_agama.setValue(data.kd_agama);
		this.form_alamat.setValue(data.alamat);
		this.form_kode_pos.setValue(data.kd_pos);
		this.form_gol_darah.setValue(data.kd_gol_darah);
		this.form_no_telp.setValue(data.no_telp);
		this.form_no_hp.setValue(data.no_hp);
		this.form_status_nikah.setValue(data.kd_status_nikah);
		this.form_operasi_komputer.setValue(data.operasi_komputer);
		this.form_kursus_komputer.setValue(data.kursus_komputer);
		this.form_sertifikasi.setValue(data.sertifikasi);
		
		this.foto.el.dom.src = _g_root + '/images/foto_guru/' + this.form_nip.getValue() + '.jpg'
	}

	this.do_add = function()
	{
		this.do_reset();
		this.dml_type	= 2;
	}

	this.do_edit = function(id)
	{
		this.dml_type	= 3;

		Ext.Ajax.request({
			url		: m_adm_pegawai_data_tenaga_administrasi_d +'data_master.jsp'
		,	params	: {
				id_pegawai	: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
			}
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					return;
				}

				this.edit_fill_form(msg);
			}
		,	scope	: this
		});
	}

	this.do_back = function()
	{
		m_adm_pegawai_data_tenaga_administrasi.panel.layout.setActiveItem(0);
	}

	this.is_valid = function()
	{
		if (!this.form_nip.isValid()) {
			return false;
		}

		if (!this.form_nm_pegawai.isValid()) {
			return false;
		}

		if (!this.form_inisial.isValid()) {
			return false;
		}

		if (!this.form_kota_lahir.isValid()) {
			return false;
		}

		if (!this.form_tanggal_lahir.isValid()) {
			return false;
		}

		if (!this.form_jenis_kelamin.isValid()) {
			return false;
		}

		if (!this.form_agama.isValid()) {
			return false;
		}

		if (!this.form_alamat.isValid()) {
			return false;
		}

		if (!this.form_gol_darah.isValid()) {
			return false;
		}

		if (!this.form_status_nikah.isValid()) {
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

		main_load.show();
		
		Ext.Ajax.request({
				url		: m_adm_pegawai_data_tenaga_administrasi_d +'submit_master.jsp'
			,	params  : {
						id_pegawai				: m_adm_pegawai_data_tenaga_administrasi_id_pegawai
					,	nip						: this.form_nip.getValue()
					,	nuptk					: this.form_nuptk.getValue()
					,	nm_pegawai				: this.form_nm_pegawai.getValue()
					,	inisial					: this.form_inisial.getValue()
					,	kota_lahir				: this.form_kota_lahir.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_jenis_kelamin		: this.form_jenis_kelamin.getValue()
					,	kd_agama				: this.form_agama.getValue()
					,	alamat					: this.form_alamat.getValue()
					,	kd_pos					: this.form_kode_pos.getValue()
					,	kd_gol_darah			: this.form_gol_darah.getValue()
					,	no_telp					: this.form_no_telp.getValue()
					,	no_hp					: this.form_no_hp.getValue()
					,	kd_status_nikah			: this.form_status_nikah.getValue()
					,	kd_jenis_ketenagaan		: '2'
					,	operasi_komputer		: this.form_operasi_komputer.getValue()
					,	kursus_komputer			: this.form_kursus_komputer.getValue()
					,	sertifikasi				: this.form_sertifikasi.getValue()
					,	dml_type				: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					main_load.hide();
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						main_load.hide();
						
						Ext.MessageBox.alert('Informasi', msg.info);

						m_adm_pegawai_data_tenaga_administrasi_master_list.store.reload();
						m_adm_pegawai_data_tenaga_administrasi.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_agama.load();
		this.store_gol_darah.load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasiMasterList(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'nip' }
		,	{ name	: 'nuptk' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'alamat' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_data_tenaga_administrasi_d +'data_master_list.jsp'
		,	autoLoad	: false
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIP'
			, dataIndex		: 'nip'
			, align			: 'center'
			, width			: 120
			, filterable	: true
			}
		,	{ header		: 'NUPTK'
			, dataIndex		: 'nuptk'
			, align			: 'center'
			, width			: 120
			, filterable	: true
			}
		,	{ header		: 'Nama Tenaga Administrasi'
			, dataIndex		: 'nm_pegawai'
			, width			: 250
			, filterable	: true
			}
		,	{ id			: 'alamat'
			, header		: 'Alamat'
			, dataIndex		: 'alamat'
			, filterable	: true
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_adm_pegawai_data_tenaga_administrasi_id_pegawai = data[0].data['id_pegawai'];						
					} else {
						m_adm_pegawai_data_tenaga_administrasi_id_pegawai = '';
					}
					
					m_adm_pegawai_data_tenaga_administrasi_master_on_select_load_detail();
				}
			}
	});

	this.btn_edit = new Ext.Button({
			text	: 'Ubah'
		,	iconCls	: 'edit16'
		,	scope	: this
		,	handler	: function() {
				this.do_edit();
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

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_edit
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'alamat'
	});

	this.do_edit = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_pegawai_data_tenaga_administrasi_master_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi_master_detail.do_edit(data.get('id_pegawai'));
		m_adm_pegawai_data_tenaga_administrasi.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_adm_pegawai_data_tenaga_administrasi_master_detail.do_add();
		m_adm_pegawai_data_tenaga_administrasi_master_detail.do_refresh();
		m_adm_pegawai_data_tenaga_administrasi.panel.layout.setActiveItem(1);
	}

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmPegawaiDataTenagaAdministrasi()
{
	m_adm_pegawai_data_tenaga_administrasi_master_list				= new M_AdmPegawaiDataTenagaAdministrasiMasterList('Data Tenaga Administrasi');
	m_adm_pegawai_data_tenaga_administrasi_master_detail			= new M_AdmPegawaiDataTenagaAdministrasiMasterDetail('Data Tenaga Administrasi');
	m_adm_pegawai_data_tenaga_administrasi_detail_keluarga			= new M_AdmPegawaiDataTenagaAdministrasiDetailKeluarga('Keluarga');
	m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal	= new M_AdmPegawaiDataTenagaAdministrasiDetailPendidikanFormal('Pendidikan Formal');
	m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_pangkat	= new M_AdmPegawaiDataTenagaAdministrasiDetailRiwayatPangkat('Riwayat Pangkat');
	m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_jabatan	= new M_AdmPegawaiDataTenagaAdministrasiDetailRiwayatJabatan('Riwayat Jabatan');
	m_adm_pegawai_data_tenaga_administrasi_detail_penataran			= new M_AdmPegawaiDataTenagaAdministrasiDetailPenataran('Penataran');

	this.panel_detail = new Ext.TabPanel({
			autoScroll		: true
		,	enableTabScroll	: true
		,	region			: 'center'
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
		,	items			: [
				m_adm_pegawai_data_tenaga_administrasi_detail_keluarga.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_pendidikan_formal.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_pangkat.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_riwayat_jabatan.panel
			,	m_adm_pegawai_data_tenaga_administrasi_detail_penataran.panel
			]
	});

	this.panel_master_detail = new Ext.Panel({
			layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoWidth		: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_adm_pegawai_data_tenaga_administrasi_master_list.panel
			,	this.panel_detail
			]
	});

	this.panel = new Ext.Panel({
			id				: 'adm_pegawai_data_tenaga_administrasi_panel'
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				this.panel_master_detail
			,	m_adm_pegawai_data_tenaga_administrasi_master_detail.panel
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_adm_pegawai_data_tenaga_administrasi_ha_level = ha_level;

		if (m_adm_pegawai_data_tenaga_administrasi_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		m_adm_pegawai_data_tenaga_administrasi_master_list.do_refresh();
	}
}

m_adm_pegawai_data_tenaga_administrasi = new M_AdmPegawaiDataTenagaAdministrasi();

//@ sourceURL=adm_pegawai_data_tenaga_administrasi.layout.js
