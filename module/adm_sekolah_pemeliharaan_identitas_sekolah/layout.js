/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_sekolah_pemeliharaan_identitas_sekolah;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_informasi_sekolah;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_kumpulan_sk;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_yayasan;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_penggunaan_laboratorium;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_psb;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_nilai_un;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_keuangan_sekolah;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_bantuan_sekolah;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_rekening_sekolah;
var m_adm_sekolah_pemeliharaan_identitas_sekolah_d = _g_root +'/module/adm_sekolah_pemeliharaan_identitas_sekolah/';
var m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level = 0;

function M_AdmSekolahPemeliharaanIdentitasSekolahInformasiSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* form items */
	this.form_email = new Ext.form.TextField({
			fieldLabel		: 'Email'
		,	vType			: 'email'
		,	vTypeText		: 'Kolom ini diisi dengan format email seperti user@contoh.com'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_website = new Ext.form.TextField({
			fieldLabel		: 'Website'
		,	vType			: 'url'
		,	vTypeText		: 'Kolom ini diisi dengan format url seperti www.contoh.com'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tahun_operasi = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Mulai Beroperasi'
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom Tahun Mulai Beroperasi adalah 4'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_tahun_dibuka = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Dibuka'
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom Tahun Dibuka adalah 4'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_tahun_akhir_renovasi = new Ext.form.NumberField({
			fieldLabel		: 'Tahun Akhir Renovasi'
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 4
		,	maxLengthText	: 'Maksimal panjang kolom Tahun Akhir Renovasi adalah 4'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_keliling_tanah = new Ext.form.NumberField({
			fieldLabel		: 'Keliling Tanah'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_dipagar_permanen = new Ext.form.NumberField({
			fieldLabel		: 'Dipagar Permanen'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_luas_siap_bangun = new Ext.form.NumberField({
			fieldLabel		: 'Luas Siap Bangun'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_luas_atas_siap_bangun = new Ext.form.NumberField({
			fieldLabel		: 'Luas Lantai Atas Siap Bangun'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_bujur = new Ext.form.NumberField({
			fieldLabel		: 'Bujur'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_lintang = new Ext.form.NumberField({
			fieldLabel		: 'Lintang'
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 100
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_email
				,	this.form_website
				,	this.form_tahun_operasi
				,	this.form_tahun_dibuka
				,	this.form_tahun_akhir_renovasi
				,	{
						xtype		: 'fieldset'
					,	title		: 'Data Geografis'
					,	collapsible	: true
					,	items		: [
								this.form_keliling_tanah
							,	this.form_dipagar_permanen
							,	this.form_luas_siap_bangun
							,	this.form_luas_atas_siap_bangun
							,	this.form_bujur
							,	this.form_lintang
						]
					}
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
		this.form_email.setValue(data.email);
		this.form_website.setValue(data.website);
		this.form_tahun_operasi.setValue(data.tahun_operasi);
		this.form_tahun_dibuka.setValue(data.tahun_dibuka);
		this.form_tahun_akhir_renovasi.setValue(data.tahun_akhir_renov);
		this.form_keliling_tanah.setValue(data.keliling_tanah);
		this.form_dipagar_permanen.setValue(data.dipagar_permanen);
		this.form_luas_siap_bangun.setValue(data.luas_siap_bangun);
		this.form_luas_atas_siap_bangun.setValue(data.luas_atas_siap_bangun);		
		this.form_bujur.setValue(data.bujur);		
		this.form_lintang.setValue(data.lintang);		
	}
	
	this.is_valid = function()
	{
		if (!this.form_email.isValid()) {
			return false;
		}

		if (!this.form_website.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						email					: this.form_email.getValue()
					,	website					: this.form_website.getValue()
					,	tahun_operasi			: this.form_tahun_operasi.getValue()
					,	tahun_dibuka			: this.form_tahun_dibuka.getValue()
					,	tahun_akhir_renov		: this.form_tahun_akhir_renovasi.getValue()
					,	keliling_tanah			: this.form_keliling_tanah.getValue()
					,	dipagar_permanen		: this.form_dipagar_permanen.getValue()
					,	luas_siap_bangun		: this.form_luas_siap_bangun.getValue()
					,	luas_atas_siap_bangun	: this.form_luas_atas_siap_bangun.getValue()
					,	bujur					: this.form_bujur.getValue()
					,	lintang					: this.form_lintang.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_informasi_sekolah.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_informasi_sekolah.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahKumpulanSK(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* store */
	this.store_kd_keterangan_sk = new Ext.data.ArrayStore({
			fields	: ['id', 'name']
		,	data	: [
				['1', 'Pemutihan']
			,	['2', 'Penegerian']
			,	['3', 'Alih Fungsi']
			,	['4', 'Sekolah Baru']
			]
	});
	
	this.store_kd_akreditasi = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d + 'data_ref_akreditasi.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	/* form items */
	this.form_no_sk_pendirian = new Ext.form.TextField({
			fieldLabel		: 'No.SK Pendirian'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_sk_pendirian = new Ext.form.DateField({
			fieldLabel	: 'Tanggal SK Pendirian'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_kd_keterangan_sk = new Ext.form.ComboBox({
			fieldLabel		: 'Keterangan SK'
		,	store			: this.store_kd_keterangan_sk
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 150
		,	msgTarget		: 'side'
	});

	this.form_no_sk_akhir_status = new Ext.form.TextField({
			fieldLabel		: 'No.SK Akhir Status'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_sk_akhir_status = new Ext.form.DateField({
			fieldLabel	: 'Tanggal SK Akhir Status'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_no_sk_akreditasi = new Ext.form.TextField({
			fieldLabel		: 'No.SK Akreditasi'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_sk_akreditasi = new Ext.form.DateField({
			fieldLabel	: 'Tanggal SK Akreditasi'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_no_sk_akreditasi_akhir = new Ext.form.TextField({
			fieldLabel		: 'No.SK Akreditasi Akhir'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_sk_akreditasi_akhir = new Ext.form.DateField({
			fieldLabel	: 'Tanggal SK Akreditasi Akhir'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	editable	: false
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_kd_akreditasi = new Ext.form.ComboBox({
			fieldLabel		: 'Akreditasi'
		,	store			: this.store_kd_akreditasi
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

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_no_sk_pendirian
				,	this.form_tanggal_sk_pendirian
				,	this.form_kd_keterangan_sk
				,	this.form_no_sk_akhir_status
				,	this.form_tanggal_sk_akhir_status
				,	this.form_no_sk_akreditasi
				,	this.form_tanggal_sk_akreditasi
				,	this.form_no_sk_akreditasi_akhir
				,	this.form_tanggal_sk_akreditasi_akhir
				,	this.form_kd_akreditasi
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
		this.form_no_sk_pendirian.setValue(data.no_sk_pendirian);
		this.form_tanggal_sk_pendirian.setValue(data.tanggal_sk_pendirian);
		this.form_kd_keterangan_sk.setValue(data.kd_keterangan_sk);
		this.form_no_sk_akhir_status.setValue(data.no_sk_akhir_status);
		this.form_tanggal_sk_akhir_status.setValue(data.tanggal_sk_akhir_status);
		this.form_no_sk_akreditasi.setValue(data.no_sk_akreditasi);
		this.form_tanggal_sk_akreditasi.setValue(data.tanggal_sk_akreditasi);
		this.form_no_sk_akreditasi_akhir.setValue(data.no_sk_akreditasi_akhir);
		this.form_tanggal_sk_akreditasi_akhir.setValue(data.tanggal_sk_akreditasi_akhir);
		this.form_kd_akreditasi.setValue(data.kd_akreditasi);
	}
	
	this.is_valid = function()
	{
		if (!this.form_kd_akreditasi.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						no_sk_pendirian				: this.form_no_sk_pendirian.getValue()
					,	tanggal_sk_pendirian		: this.form_tanggal_sk_pendirian.getValue()
					,	kd_keterangan_sk			: this.form_kd_keterangan_sk.getValue()
					,	no_sk_akhir_status			: this.form_no_sk_akhir_status.getValue()
					,	tanggal_sk_akhir_status		: this.form_tanggal_sk_akhir_status.getValue()
					,	no_sk_akreditasi			: this.form_no_sk_akreditasi.getValue()
					,	tanggal_sk_akreditasi		: this.form_tanggal_sk_akreditasi.getValue()
					,	no_sk_akreditasi_akhir		: this.form_no_sk_akreditasi_akhir.getValue()
					,	tanggal_sk_akreditasi_akhir	: this.form_tanggal_sk_akreditasi_akhir.getValue()
					,	kd_akreditasi				: this.form_kd_akreditasi.getValue()
					,	dml_type					: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_kumpulan_sk.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_kumpulan_sk.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_kd_akreditasi.load();
		
		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahYayasan(title)
{
	this.title			= title;
	this.dml_type		= 0;
	this.id_propinsi	= 0;
	this.id_kabupaten	= 0;

	/* store */
	this.store_kd_akreditasi = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d + 'data_ref_akreditasi.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	this.store_propinsi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_ref_propinsi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kabupaten = new Ext.data.ArrayStore({
			fields		: ['id_pro','id','name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_ref_kabupaten.jsp'
		,	idIndex		: 1
		,	autoLoad	: false
	});

	this.store_kecamatan = new Ext.data.ArrayStore({
			fields		: ['id_pro','id_kab','id','name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_ref_kecamatan.jsp'
		,	idIndex		: 2
		,	autoLoad	: false
	});

	this.store_kd_kel_yayasan = new Ext.data.ArrayStore({
			fields		: ['id', 'name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d + 'data_ref_kel_yayasan.jsp'
		,	autoLoad	: false
		,	idIndex		: 0
	});

	/* form items */
	this.form_kd_akreditasi = new Ext.form.ComboBox({
			fieldLabel		: 'Status Akreditasi Swasta'
		,	store			: this.store_kd_akreditasi
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

	this.form_no_data_sekolah = new Ext.form.TextField({
			fieldLabel		: 'Nomor Data Sekolah (NDS)'
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_nm_yayasan = new Ext.form.TextField({
			fieldLabel		: 'Nama Yayasan / Penyelenggara Sekolah'
		,	allowBlank		: false
		,	width			: 300
		,	msgTarget		: 'side'
	});

	this.form_jalan_yayasan = new Ext.form.TextArea({
			fieldLabel		: 'Jalan'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_propinsi = new Ext.form.ComboBox({
			fieldLabel		: 'Propinsi'
		,	store			: this.store_propinsi
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
		,	listeners	: {
					scope	: this
				,	select	: function(cb, record, index) {
						this.form_propinsi_on_select(record.get('id'));
					}
			}
	});

	this.form_kabupaten = new Ext.form.ComboBox({
			fieldLabel		: 'Kabupaten'
		,	store			: this.store_kabupaten
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
		,	listeners	: {
					scope	: this
				,	select	: function(cb, record, index) {
						this.form_kabupaten_on_select(record.get('id'));
					}
			}
	});

	this.form_kecamatan = new Ext.form.ComboBox({
			fieldLabel		: 'Kecamatan'
		,	store			: this.store_kecamatan
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

	this.form_kd_desa_yayasan = new Ext.form.TextField({
			fieldLabel		: 'Desa'
		,	allowBlank		: false
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_no_akte_yayasan = new Ext.form.TextField({
			fieldLabel		: 'Akte Pendirian'
		,	allowBlank		: false
		,	width			: 200
		,	msgTarget		: 'side'
	});

	this.form_tanggal_akte_yayasan = new Ext.form.DateField({
			fieldLabel	: 'Tanggal Akte Yayasan'
		,	emptyText	: 'Tahun-Bulan-Tanggal'
		,	format		: 'Y-m-d'
		,	allowBlank	: false
		,	editable	: false
		,	width		: 150
		,	msgTarget	: 'side'
	});

	this.form_kd_kel_yayasan = new Ext.form.ComboBox({
			fieldLabel		: 'Kelompok Yayasan'
		,	store			: this.store_kd_kel_yayasan
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

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_kd_akreditasi
				,	this.form_no_data_sekolah
				,	this.form_nm_yayasan
				,	{
						xtype		: 'fieldset'
					,	title		: 'Alamat'
					,	collapsible	: true
					,	items		: [
								this.form_jalan_yayasan
							,	this.form_propinsi
							,	this.form_kabupaten
							,	this.form_kecamatan
							,	this.form_kd_desa_yayasan
						]
					}
				,	this.form_no_akte_yayasan
				,	this.form_tanggal_akte_yayasan
				,	this.form_kd_kel_yayasan
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
	this.form_kecamatan_filter = function(r,id)
	{
		return (r.get('id_pro') == this.id_propinsi
			&& r.get('id_kab') == this.id_kabupaten);
	}

	this.form_kabupaten_on_select = function(id_kabupaten)
	{
		this.id_kabupaten = id_kabupaten;

		if (this.id_kabupaten != 'undefined' && this.id_kabupaten != '') {
			this.form_kecamatan.clearFilter(true);
			this.form_kecamatan.filterBy(this.form_kecamatan_filter, this);
			this.form_kecamatan.setValue(this.store_kecamatan.getAt(0).get('id'));
		} else {
			this.form_kecamatan.clearFilter(true);
		}
	}

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

			var id = this.store_kabupaten.getAt(0).get('id');

			this.form_kabupaten.setValue(id);
			this.form_kabupaten_on_select(id);
		} else {
			this.form_kabupaten.clearFilter(true);
		}
	}

	this.edit_fill_form = function(data)
	{
		this.form_kd_akreditasi.setValue(data.kd_akreditasi);
		this.form_no_data_sekolah.setValue(data.no_data_sekolah);
		this.form_nm_yayasan.setValue(data.nm_yayasan);
		this.form_jalan_yayasan.setValue(data.jalan_yayasan);
		this.form_propinsi.setValue(data.id_propinsi);
		this.form_kabupaten.setValue(data.id_kabupaten);
		this.form_kecamatan.setValue(data.id_kecamatan);
		this.form_kd_desa_yayasan.setValue(data.kd_desa_yayasan);
		this.form_no_akte_yayasan.setValue(data.no_akte_yayasan);
		this.form_tanggal_akte_yayasan.setValue(data.tanggal_akte_yayasan);
		this.form_kd_kel_yayasan.setValue(data.kd_kel_yayasan);
	}
	
	this.is_valid = function()
	{
		if (!this.form_kd_akreditasi.isValid()) {
			return false;
		}

		if (!this.form_nm_yayasan.isValid()) {
			return false;
		}

		if (!this.form_jalan_yayasan.isValid()) {
			return false;
		}

		if (!this.form_propinsi.isValid()) {
			return false;
		}

		if (!this.form_kabupaten.isValid()) {
			return false;
		}

		if (!this.form_kecamatan.isValid()) {
			return false;
		}

		if (!this.form_kd_desa_yayasan.isValid()) {
			return false;
		}

		if (!this.form_no_akte_yayasan.isValid()) {
			return false;
		}

		if (!this.form_tanggal_akte_yayasan.isValid()) {
			return false;
		}

		if (!this.form_kd_kel_yayasan.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						kd_akreditasi			: this.form_kd_akreditasi.getValue()
					,	no_data_sekolah			: this.form_no_data_sekolah.getValue()
					,	nm_yayasan				: this.form_nm_yayasan.getValue()
					,	jalan_yayasan			: this.form_jalan_yayasan.getValue()
					,	id_propinsi				: this.form_propinsi.getValue()
					,	id_kabupaten			: this.form_kabupaten.getValue()
					,	id_kecamatan			: this.form_kecamatan.getValue()
					,	kd_desa_yayasan			: this.form_kd_desa_yayasan.getValue()
					,	no_akte_yayasan			: this.form_no_akte_yayasan.getValue()
					,	tanggal_akte_yayasan	: this.form_tanggal_akte_yayasan.getValue()
					,	kd_kel_yayasan			: this.form_kd_kel_yayasan.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_yayasan.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_yayasan.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.store_kd_akreditasi.load({
				callback	: function(){
					this.store_propinsi.load({
							callback	: function(){
								this.store_kabupaten.load({
										callback	: function(){
											this.store_kecamatan.load({
													callback	: function(){
														this.store_kd_kel_yayasan.load({
																callback	: function(){
																	this.do_load();
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
				}
			,	scope		: this
		});
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahPenggunaanLaboratorium(title)
{
	this.title			= title;
	this.dml_type		= 0;

	/* form items */
	this.form_jml_jam_lab_ipa = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium IPA'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_kimia = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium Kimia'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_fisika = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium Fisika'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_biologi = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium Biologi'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_bahasa = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium Bahasa'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_ips = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium IPS'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_komputer = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium Komputer'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_jam_lab_multimedia = new Ext.form.NumberField({
			fieldLabel		: 'Laboratorium Multimedia'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 2
		,	maxLengthText	: 'Maksimal panjang kolom adalah 2'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_jml_jam_lab_ipa
				,	this.form_jml_jam_lab_kimia
				,	this.form_jml_jam_lab_fisika
				,	this.form_jml_jam_lab_biologi
				,	this.form_jml_jam_lab_bahasa
				,	this.form_jml_jam_lab_ips
				,	this.form_jml_jam_lab_komputer
				,	this.form_jml_jam_lab_multimedia
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
		this.form_jml_jam_lab_ipa.setValue(data.jml_jam_lab_ipa);
		this.form_jml_jam_lab_kimia.setValue(data.jml_jam_lab_kimia);
		this.form_jml_jam_lab_fisika.setValue(data.jml_jam_lab_fisika);
		this.form_jml_jam_lab_biologi.setValue(data.jml_jam_lab_biologi);
		this.form_jml_jam_lab_bahasa.setValue(data.jml_jam_lab_bahasa);
		this.form_jml_jam_lab_ips.setValue(data.jml_jam_lab_ips);
		this.form_jml_jam_lab_komputer.setValue(data.jml_jam_lab_komputer);
		this.form_jml_jam_lab_multimedia.setValue(data.jml_jam_lab_multimedia);
	}
	
	this.is_valid = function()
	{
		if (!this.form_jml_jam_lab_ipa.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_kimia.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_fisika.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_biologi.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_bahasa.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_ips.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_komputer.isValid()) {
			return false;
		}

		if (!this.form_jml_jam_lab_multimedia.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk merubah data!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						jml_jam_lab_ipa			: this.form_jml_jam_lab_ipa.getValue()
					,	jml_jam_lab_kimia		: this.form_jml_jam_lab_kimia.getValue()
					,	jml_jam_lab_fisika		: this.form_jml_jam_lab_fisika.getValue()
					,	jml_jam_lab_biologi		: this.form_jml_jam_lab_biologi.getValue()
					,	jml_jam_lab_bahasa		: this.form_jml_jam_lab_bahasa.getValue()
					,	jml_jam_lab_ips			: this.form_jml_jam_lab_ips.getValue()
					,	jml_jam_lab_komputer	: this.form_jml_jam_lab_komputer.getValue()
					,	jml_jam_lab_multimedia	: this.form_jml_jam_lab_multimedia.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_penggunaan_laboratorium.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_penggunaan_laboratorium.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahPSB(title)
{
	this.title			= title;
	this.dml_type		= 0;

	/* form items */
	this.form_rata_un = new Ext.form.NumberField({
			fieldLabel		: 'Nilai Rata-Rata UN Calon Siswa'
		,	allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_renc_term = new Ext.form.NumberField({
			fieldLabel		: 'Rencana Penerimaan'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom adalah 5'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_daft_l = new Ext.form.NumberField({
			fieldLabel		: 'Laki-Laki'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom adalah 5'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_jml_daft_p = new Ext.form.NumberField({
			fieldLabel		: 'Perempuan'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 5
		,	maxLengthText	: 'Maksimal panjang kolom adalah 5'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_rata_un
				,	this.form_renc_term
				,	{
						xtype	: 'fieldset'
					,	title	: 'Jumlah Pendaftar'
					,	items	: [
							this.form_jml_daft_l
						,	this.form_jml_daft_p
						]
					}
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
		this.form_rata_un.setValue(data.rata_un);
		this.form_renc_term.setValue(data.renc_term);
		this.form_jml_daft_l.setValue(data.jml_daft_l);
		this.form_jml_daft_p.setValue(data.jml_daft_p);
	}
	
	this.is_valid = function()
	{
		if (!this.form_rata_un.isValid()) {
			return false;
		}

		if (!this.form_renc_term.isValid()) {
			return false;
		}

		if (!this.form_jml_daft_l.isValid()) {
			return false;
		}

		if (!this.form_jml_daft_p.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						rata_un		: this.form_rata_un.getValue()
					,	renc_term	: this.form_renc_term.getValue()
					,	jml_daft_l	: this.form_jml_daft_l.getValue()
					,	jml_daft_p	: this.form_jml_daft_p.getValue()
					,	dml_type	: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_psb.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_psb.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahNilaiUN(title)
{
	this.title			= title;
	this.dml_type		= 0;

	/* form items */
	this.form_nilai_un_indo = new Ext.form.NumberField({
			fieldLabel		: 'Nilai Bahasa Indonesia'
		,	allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 10
		,	maxText			: 'Nilai Maksimal adalah 10'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_nilai_un_mat = new Ext.form.NumberField({
			fieldLabel		: 'Nilai Matematika'
		,	allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 10
		,	maxText			: 'Nilai Maksimal adalah 10'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_nilai_un_ing = new Ext.form.NumberField({
			fieldLabel		: 'Nilai Bahasa Inggris'
		,	allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 10
		,	maxText			: 'Nilai Maksimal adalah 10'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	this.form_nilai_un_ipa = new Ext.form.NumberField({
			fieldLabel		: 'Nilai IPA'
		,	allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 10
		,	maxText			: 'Nilai Maksimal adalah 10'
		,	width			: 50
		,	msgTarget		: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 200
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_nilai_un_indo
				,	this.form_nilai_un_mat
				,	this.form_nilai_un_ing
				,	this.form_nilai_un_ipa
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
		this.form_nilai_un_indo.setValue(data.nilai_un_indo);
		this.form_nilai_un_mat.setValue(data.nilai_un_mat);
		this.form_nilai_un_ing.setValue(data.nilai_un_ing);
		this.form_nilai_un_ipa.setValue(data.nilai_un_ipa);
	}
	
	this.is_valid = function()
	{
		if (!this.form_nilai_un_indo.isValid()) {
			return false;
		}

		if (!this.form_nilai_un_mat.isValid()) {
			return false;
		}

		if (!this.form_nilai_un_ing.isValid()) {
			return false;
		}

		if (!this.form_nilai_un_ipa.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						nilai_un_indo	: this.form_nilai_un_indo.getValue()
					,	nilai_un_mat	: this.form_nilai_un_mat.getValue()
					,	nilai_un_ing	: this.form_nilai_un_ing.getValue()
					,	nilai_un_ipa	: this.form_nilai_un_ipa.getValue()
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_nilai_un.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_nilai_un.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahKeuanganSekolah(title)
{
	this.title					= title;
	this.dml_type				= 0;
	this.saldo_awal				= 0;
	this.trm_gaji_ksr_guru		= 0;
	this.trm_gaji_ksr_pgw		= 0;
	this.trm_gaji_ksr_gurubantu	= 0;
	this.trm_bos_reguler		= 0;
	this.trm_bos_buku			= 0;
	this.trm_bomm				= 0;
	this.trm_bkm				= 0;
	this.trm_bop				= 0;
	this.trm_gj_pgw				= 0;
	this.trm_opr_hara			= 0;
	this.trm_adm				= 0;
	this.trm_swasta_non			= 0;
	this.trm_pangkal_bangku		= 0;
	this.trm_komite				= 0;
	this.trm_eks_kul			= 0;
	this.trm_lain				= 0;
	this.trm_prod				= 0;
	this.trm_sumber_lain		= 0;
	this.byr_guru				= 0;
	this.byr_dpk				= 0;
	this.byr_guru_hon			= 0;
	this.byr_bantu				= 0;
	this.byr_guru_kesra			= 0;
	this.byr_pgw				= 0;
	this.byr_pgw_hon			= 0;
	this.byr_pgw_kesra			= 0;
	this.byr_pbm				= 0;
	this.byr_gedung				= 0;
	this.byr_alat				= 0;
	this.byr_perabot			= 0;
	this.byr_rehab				= 0;
	this.byr_buku				= 0;
	this.byr_ada_lain			= 0;
	this.byr_eks_kul			= 0;
	this.byr_daya_jasa			= 0;
	this.byr_tu_adm				= 0;
	this.byr_lain				= 0;
	this.saldo_akhir			= 0;

	/* form items */
	this.form_saldo_awal = new Ext.ux.NumericField({
			fieldLabel				: 'Saldo Awal'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.saldo_awal = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_gaji_ksr_guru = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji dan Kesra Guru'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_gaji_ksr_guru = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_gaji_ksr_pgw = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji dan Kesra Pegawai'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_gaji_ksr_pgw = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_gaji_ksr_gurubantu = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji dan Kesra Guru Bantu'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_gaji_ksr_gurubantu = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_bos_reguler = new Ext.ux.NumericField({
			fieldLabel				: 'BOS Reguler'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_bos_reguler = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_bos_buku = new Ext.ux.NumericField({
			fieldLabel				: 'BOS Buku'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_bos_buku = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_bomm = new Ext.ux.NumericField({
			fieldLabel				: 'BOMM'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_bomm = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_bkm = new Ext.ux.NumericField({
			fieldLabel				: 'BKM'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_bkm = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_bop = new Ext.ux.NumericField({
			fieldLabel				: 'BOP'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_bop = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_gj_pgw = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Pegawai'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_gj_pgw = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_opr_hara = new Ext.ux.NumericField({
			fieldLabel				: 'Operasi / Pemeliharaan'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_opr_hara = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_adm = new Ext.ux.NumericField({
			fieldLabel				: 'Administrasi'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_adm = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_swasta_non = new Ext.ux.NumericField({
			fieldLabel				: 'Lembaga Swasta Non Pendidikan'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_swasta_non = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_pangkal_bangku = new Ext.ux.NumericField({
			fieldLabel				: 'Uang Pangkal / Bangku'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_pangkal_bangku = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_komite = new Ext.ux.NumericField({
			fieldLabel				: 'Uang Komite Sekolah'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_komite = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_eks_kul = new Ext.ux.NumericField({
			fieldLabel				: 'Uang Ekstrakurikuler'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_eks_kul = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_lain = new Ext.ux.NumericField({
			fieldLabel				: 'Lain-Lain'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_lain = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_prod = new Ext.ux.NumericField({
			fieldLabel				: 'Unit Produksi'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_prod = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_trm_sumber_lain = new Ext.ux.NumericField({
			fieldLabel				: 'Sumber Lain'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.trm_sumber_lain = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_jml_penerimaan = new Ext.ux.NumericField({
			fieldLabel				: 'Jumlah Penerimaan'
		,	allowDecimals			: true
		,	allowNegative			: false
		,	labelStyle				: 'font-weight:bold'
		,	readOnly				: true
		,	alwaysDisplayDecimals	: true
		,	width					: 130
	});

	this.form_byr_guru = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Guru'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_guru = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_dpk = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Guru DPK'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_dpk = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_guru_hon = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Guru Honorer'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_guru_hon = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_bantu = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Guru Bantu / Kontrak'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_bantu = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_guru_kesra = new Ext.ux.NumericField({
			fieldLabel				: 'Kesra Guru'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_guru_kesra = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_pgw = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Pegawai'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_pgw = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_pgw_hon = new Ext.ux.NumericField({
			fieldLabel				: 'Gaji Pegawai Honorer'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_pgw_hon = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_pgw_kesra = new Ext.ux.NumericField({
			fieldLabel				: 'Kesra Pegawai'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_pgw_kesra = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_pbm = new Ext.ux.NumericField({
			fieldLabel				: 'Proses Belajar Mengajar'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_pbm = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_gedung = new Ext.ux.NumericField({
			fieldLabel				: 'Gedung'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_gedung = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_alat = new Ext.ux.NumericField({
			fieldLabel				: 'Alat'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_alat = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_perabot = new Ext.ux.NumericField({
			fieldLabel				: 'Perabot'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_perabot = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_rehab = new Ext.ux.NumericField({
			fieldLabel				: 'Rehabilitasi'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_rehab = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_buku = new Ext.ux.NumericField({
			fieldLabel				: 'Pengadaan Buku'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_buku = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_ada_lain = new Ext.ux.NumericField({
			fieldLabel				: 'Pengadaan Lainnya'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_ada_lain = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_eks_kul = new Ext.ux.NumericField({
			fieldLabel				: 'Ekstrakurikuler'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_eks_kul = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_daya_jasa = new Ext.ux.NumericField({
			fieldLabel				: 'Daya dan Jasa'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_daya_jasa = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_tu_adm = new Ext.ux.NumericField({
			fieldLabel				: 'Tata Usaha / Administrasi'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_tu_adm = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_byr_lain = new Ext.ux.NumericField({
			fieldLabel				: 'Lainnya'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	width					: 120
		,	msgTarget				: 'side'
		,	listeners	: {
				change	: function(form, newvalue, oldvalue) {
					this.byr_lain = newvalue;
					this.do_compute();
				}
			,	scope	: this
			}
	});

	this.form_jml_pengeluaran = new Ext.ux.NumericField({
			fieldLabel				: 'Jumlah Pengeluaran'
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
		,	readOnly				: true
		,	labelStyle				: 'font-weight:bold'
		,	width					: 130
	});

	this.form_saldo_akhir = new Ext.ux.NumericField({
			fieldLabel				: 'Saldo Akhir'
		,	allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: true
		,	readOnly				: true
		,	alwaysDisplayDecimals	: true
		,	labelStyle				: 'font-weight:bold'
		,	width					: 130
		,	msgTarget				: 'side'
	});

	/* form */
	this.panel_form = new Ext.form.FormPanel({
			layout			: 'column'
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
				{
					columnWidth	: 0.5
				,	layout		: 'form'
				,	baseCls		: 'x-plain'
				,	labelAlign	: 'right'
				,	labelWidth	: 170
				,	items		: [
						{
							xtype	: 'fieldset'
						,	title	: 'PENERIMAAN DANA'
						,	items	: [
								this.form_saldo_awal
							,	{
									xtype	: 'fieldset'
								,	title	: 'Pemerintah Daerah / Kota'
								,	items	: [
										this.form_trm_gaji_ksr_guru
									,	this.form_trm_gaji_ksr_pgw
									,	this.form_trm_gaji_ksr_gurubantu
									]
								}
							,	this.form_trm_bos_reguler
							,	this.form_trm_bos_buku
							,	this.form_trm_bomm
							,	this.form_trm_bkm
							,	this.form_trm_bop
							,	{
									xtype	: 'fieldset'
								,	title	: 'Yayasan Pendidikan (Swasta)'
								,	items	: [
										this.form_trm_gj_pgw
									,	this.form_trm_opr_hara
									,	this.form_trm_adm
									]
								}
							,	this.form_trm_swasta_non
							,	{
									xtype	: 'fieldset'
								,	title	: 'Orangtua Siswa dan Masyarakat'
								,	items	: [
										this.form_trm_pangkal_bangku
									,	this.form_trm_komite
									,	this.form_trm_eks_kul
									,	this.form_trm_lain
									]
								}
							,	this.form_trm_prod
							,	this.form_trm_sumber_lain
							,	{
									xtype	: 'fieldset'
								,	items	: [
										this.form_jml_penerimaan
									]
								}
							]
						}
					]
				}
			,	{
					columnWidth	: 0.5
				,	layout		: 'form'
				,	baseCls		: 'x-plain'
				,	labelAlign	: 'right'
				,	labelWidth	: 170
				,	items		: [
						{
							xtype	: 'fieldset'
						,	title	: 'PENGELUARAN DANA'
						,	items	: [
								{
									xtype	: 'fieldset'
								,	title	: 'Gaji dan Kesra Guru'
								,	items	: [
										this.form_byr_guru
									,	this.form_byr_dpk
									,	this.form_byr_guru_hon
									,	this.form_byr_bantu
									,	this.form_byr_guru_kesra
									]
								}
							,	{
									xtype	: 'fieldset'
								,	title	: 'Gaji dan Kesra Pegawai'
								,	items	: [
										this.form_byr_pgw
									,	this.form_byr_pgw_hon
									,	this.form_byr_pgw_kesra
									]
								}
							,	this.form_byr_pbm
							,	{
									xtype	: 'fieldset'
								,	title	: 'Pemeliharaan Sarana dan Prasarana'
								,	items	: [
										this.form_byr_gedung
									,	this.form_byr_alat
									,	this.form_byr_perabot
									]								
								}
							,	this.form_byr_rehab
							,	{
									xtype	: 'fieldset'
								,	title	: 'Pengadaan Sarana dan Prasarana'
								,	items	: [
										this.form_byr_buku
									,	this.form_byr_ada_lain
									]								
								}
							,	this.form_byr_eks_kul
							,	this.form_byr_daya_jasa
							,	this.form_byr_tu_adm
							,	this.form_byr_lain
							,	{
									xtype	: 'fieldset'
								,	items	: [
										this.form_saldo_akhir
									]
								}
							,	{
									xtype	: 'fieldset'
								,	items	: [
										this.form_jml_pengeluaran
									]
								}
							]
						}
					]
				}
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
	this.do_compute = function()
	{
		var penerimaan 	= 0;
		var pengeluaran = 0;
		var saldoAkhir	= 0;
		
		penerimaan 	=	this.saldo_awal +
						this.trm_gaji_ksr_guru +
						this.trm_gaji_ksr_pgw +
						this.trm_gaji_ksr_gurubantu	+
						this.trm_bos_reguler +
						this.trm_bos_buku +
						this.trm_bomm +
						this.trm_bkm +
						this.trm_bop +
						this.trm_gj_pgw	+
						this.trm_opr_hara +
						this.trm_adm +
						this.trm_swasta_non	+
						this.trm_pangkal_bangku	+
						this.trm_komite	+
						this.trm_eks_kul +
						this.trm_lain +
						this.trm_prod +
						this.trm_sumber_lain;
		
		pengeluaran	=	this.byr_guru +
						this.byr_dpk +
						this.byr_guru_hon +
						this.byr_bantu +
						this.byr_guru_kesra	+
						this.byr_pgw +
						this.byr_pgw_hon +
						this.byr_pgw_kesra +
						this.byr_pbm +
						this.byr_gedung	+
						this.byr_alat +
						this.byr_perabot +
						this.byr_rehab +
						this.byr_buku +
						this.byr_ada_lain +
						this.byr_eks_kul +
						this.byr_daya_jasa +
						this.byr_tu_adm	+
						this.byr_lain;
		
		saldoAkhir	=	penerimaan - pengeluaran;
		
		this.form_jml_penerimaan.setValue(penerimaan);
		
		this.form_jml_pengeluaran.setValue(penerimaan);
		
		this.form_saldo_akhir.setValue(saldoAkhir);
	}
	
	this.edit_fill_form = function(data)
	{
		this.form_saldo_awal.setValue(data.saldo_awal);
		this.form_trm_gaji_ksr_guru.setValue(data.trm_gaji_ksr_guru);
		this.form_trm_gaji_ksr_pgw.setValue(data.trm_gaji_ksr_pgw);
		this.form_trm_gaji_ksr_gurubantu.setValue(data.trm_gaji_ksr_gurubantu);
		this.form_trm_bos_reguler.setValue(data.trm_bos_reguler);
		this.form_trm_bos_buku.setValue(data.trm_bos_buku);
		this.form_trm_bomm.setValue(data.trm_bomm);
		this.form_trm_bkm.setValue(data.trm_bkm);
		this.form_trm_bop.setValue(data.trm_bop);
		this.form_trm_gj_pgw.setValue(data.trm_gj_pgw);
		this.form_trm_opr_hara.setValue(data.trm_opr_hara);
		this.form_trm_adm.setValue(data.trm_adm);
		this.form_trm_swasta_non.setValue(data.trm_swasta_non);
		this.form_trm_pangkal_bangku.setValue(data.trm_pangkal_bangku);
		this.form_trm_komite.setValue(data.trm_komite);
		this.form_trm_eks_kul.setValue(data.trm_eks_kul);
		this.form_trm_lain.setValue(data.trm_lain);
		this.form_trm_prod.setValue(data.trm_prod);
		this.form_trm_sumber_lain.setValue(data.trm_sumber_lain);
		this.form_byr_guru.setValue(data.byr_guru);
		this.form_byr_dpk.setValue(data.byr_dpk);
		this.form_byr_guru_hon.setValue(data.byr_guru_hon);
		this.form_byr_bantu.setValue(data.byr_bantu);
		this.form_byr_guru_kesra.setValue(data.byr_guru_kesra);
		this.form_byr_pgw.setValue(data.byr_pgw);
		this.form_byr_pgw_hon.setValue(data.byr_pgw_hon);
		this.form_byr_pgw_kesra.setValue(data.byr_pgw_kesra);
		this.form_byr_pbm.setValue(data.byr_pbm);
		this.form_byr_gedung.setValue(data.byr_gedung);
		this.form_byr_alat.setValue(data.byr_alat);
		this.form_byr_perabot.setValue(data.byr_perabot);
		this.form_byr_rehab.setValue(data.byr_rehab);
		this.form_byr_buku.setValue(data.byr_buku);
		this.form_byr_ada_lain.setValue(data.byr_ada_lain);
		this.form_byr_eks_kul.setValue(data.byr_eks_kul);
		this.form_byr_daya_jasa.setValue(data.byr_daya_jasa);
		this.form_byr_tu_adm.setValue(data.byr_tu_adm);
		this.form_byr_lain.setValue(data.byr_lain);
		this.form_saldo_akhir.setValue(data.saldo_akhir);

		this.saldo_awal				= this.form_saldo_awal.getValue();
		this.trm_gaji_ksr_guru		= this.form_trm_gaji_ksr_guru.getValue();
		this.trm_gaji_ksr_pgw		= this.form_trm_gaji_ksr_pgw.getValue();
		this.trm_gaji_ksr_gurubantu	= this.form_trm_gaji_ksr_gurubantu.getValue();
		this.trm_bos_reguler		= this.form_trm_bos_reguler.getValue();
		this.trm_bos_buku			= this.form_trm_bos_buku.getValue();
		this.trm_bomm				= this.form_trm_bomm.getValue();
		this.trm_bkm				= this.form_trm_bkm.getValue();
		this.trm_bop				= this.form_trm_bop.getValue();
		this.trm_gj_pgw				= this.form_trm_gj_pgw.getValue();
		this.trm_opr_hara			= this.form_trm_opr_hara.getValue();
		this.trm_adm				= this.form_trm_adm.getValue();
		this.trm_swasta_non			= this.form_trm_swasta_non.getValue();
		this.trm_pangkal_bangku		= this.form_trm_pangkal_bangku.getValue();
		this.trm_komite				= this.form_trm_komite.getValue();
		this.trm_eks_kul			= this.form_trm_eks_kul.getValue();
		this.trm_lain				= this.form_trm_lain.getValue();
		this.trm_prod				= this.form_trm_prod.getValue();
		this.trm_sumber_lain		= this.form_trm_sumber_lain.getValue();
		this.byr_guru				= this.form_byr_guru.getValue();
		this.byr_dpk				= this.form_byr_dpk.getValue();
		this.byr_guru_hon			= this.form_byr_guru_hon.getValue();
		this.byr_bantu				= this.form_byr_bantu.getValue();
		this.byr_guru_kesra			= this.form_byr_guru_kesra.getValue();
		this.byr_pgw				= this.form_byr_pgw.getValue();
		this.byr_pgw_hon			= this.form_byr_pgw_hon.getValue();
		this.byr_pgw_kesra			= this.form_byr_pgw_kesra.getValue();
		this.byr_pbm				= this.form_byr_pbm.getValue();
		this.byr_gedung				= this.form_byr_gedung.getValue();
		this.byr_alat				= this.form_byr_alat.getValue();
		this.byr_perabot			= this.form_byr_perabot.getValue();
		this.byr_rehab				= this.form_byr_rehab.getValue();
		this.byr_buku				= this.form_byr_buku.getValue();
		this.byr_ada_lain			= this.form_byr_ada_lain.getValue();
		this.byr_eks_kul			= this.form_byr_eks_kul.getValue();
		this.byr_daya_jasa			= this.form_byr_daya_jasa.getValue();
		this.byr_tu_adm				= this.form_byr_tu_adm.getValue();
		this.byr_lain				= this.form_byr_lain.getValue();
		this.saldo_akhir			= this.form_saldo_akhir.getValue();
		
		this.do_compute();
	}
	
	this.is_valid = function()
	{
		if (!this.form_saldo_awal.isValid()) {
			return false;
		}
		if (!this.form_trm_gaji_ksr_guru.isValid()) {
			return false;
		}
		if (!this.form_trm_gaji_ksr_pgw.isValid()) {
			return false;
		}
		if (!this.form_trm_gaji_ksr_gurubantu.isValid()) {
			return false;
		}
		if (!this.form_trm_bos_reguler.isValid()) {
			return false;
		}
		if (!this.form_trm_bos_buku.isValid()) {
			return false;
		}
		if (!this.form_trm_bomm.isValid()) {
			return false;
		}
		if (!this.form_trm_bkm.isValid()) {
			return false;
		}
		if (!this.form_trm_bop.isValid()) {
			return false;
		}
		if (!this.form_trm_gj_pgw.isValid()) {
			return false;
		}
		if (!this.form_trm_opr_hara.isValid()) {
			return false;
		}
		if (!this.form_trm_adm.isValid()) {
			return false;
		}
		if (!this.form_trm_swasta_non.isValid()) {
			return false;
		}
		if (!this.form_trm_pangkal_bangku.isValid()) {
			return false;
		}
		if (!this.form_trm_komite.isValid()) {
			return false;
		}
		if (!this.form_trm_eks_kul.isValid()) {
			return false;
		}
		if (!this.form_trm_lain.isValid()) {
			return false;
		}
		if (!this.form_trm_prod.isValid()) {
			return false;
		}
		if (!this.form_trm_sumber_lain.isValid()) {
			return false;
		}
		if (!this.form_byr_guru.isValid()) {
			return false;
		}
		if (!this.form_byr_dpk.isValid()) {
			return false;
		}
		if (!this.form_byr_guru_hon.isValid()) {
			return false;
		}
		if (!this.form_byr_bantu.isValid()) {
			return false;
		}
		if (!this.form_byr_guru_kesra.isValid()) {
			return false;
		}
		if (!this.form_byr_pgw.isValid()) {
			return false;
		}
		if (!this.form_byr_pgw_hon.isValid()) {
			return false;
		}
		if (!this.form_byr_pgw_kesra.isValid()) {
			return false;
		}
		if (!this.form_byr_pbm.isValid()) {
			return false;
		}
		if (!this.form_byr_gedung.isValid()) {
			return false;
		}
		if (!this.form_byr_alat.isValid()) {
			return false;
		}
		if (!this.form_byr_perabot.isValid()) {
			return false;
		}
		if (!this.form_byr_rehab.isValid()) {
			return false;
		}
		if (!this.form_byr_buku.isValid()) {
			return false;
		}
		if (!this.form_byr_ada_lain.isValid()) {
			return false;
		}
		if (!this.form_byr_eks_kul.isValid()) {
			return false;
		}
		if (!this.form_byr_daya_jasa.isValid()) {
			return false;
		}
		if (!this.form_byr_tu_adm.isValid()) {
			return false;
		}
		if (!this.form_byr_lain.isValid()) {
			return false;
		}

		return true;
	}
	
	this.do_save = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2) {
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			return;
		}

		if (!this.is_valid()) {
			Ext.MessageBox.alert('Kesalahan', 'Form belum terisi dengan benar!');
			return;
		}

		Ext.Ajax.request({
				params  : {
						saldo_awal				: this.form_saldo_awal.getValue()
					,	trm_gaji_ksr_guru		: this.form_trm_gaji_ksr_guru.getValue()
					,	trm_gaji_ksr_pgw		: this.form_trm_gaji_ksr_pgw.getValue()
					,	trm_gaji_ksr_gurubantu	: this.form_trm_gaji_ksr_gurubantu.getValue()
					,	trm_bos_reguler			: this.form_trm_bos_reguler.getValue()
					,	trm_bos_buku			: this.form_trm_bos_buku.getValue()
					,	trm_bomm				: this.form_trm_bomm.getValue()
					,	trm_bkm					: this.form_trm_bkm.getValue()
					,	trm_bop					: this.form_trm_bop.getValue()
					,	trm_gj_pgw				: this.form_trm_gj_pgw.getValue()
					,	trm_opr_hara			: this.form_trm_opr_hara.getValue()
					,	trm_adm					: this.form_trm_adm.getValue()
					,	trm_swasta_non			: this.form_trm_swasta_non.getValue()
					,	trm_pangkal_bangku		: this.form_trm_pangkal_bangku.getValue()
					,	trm_komite				: this.form_trm_komite.getValue()
					,	trm_eks_kul				: this.form_trm_eks_kul.getValue()
					,	trm_lain				: this.form_trm_lain.getValue()
					,	trm_prod				: this.form_trm_prod.getValue()
					,	trm_sumber_lain			: this.form_trm_sumber_lain.getValue()
					,	byr_guru				: this.form_byr_guru.getValue()
					,	byr_dpk					: this.form_byr_dpk.getValue()
					,	byr_guru_hon			: this.form_byr_guru_hon.getValue()
					,	byr_bantu				: this.form_byr_bantu.getValue()
					,	byr_guru_kesra			: this.form_byr_guru_kesra.getValue()
					,	byr_pgw					: this.form_byr_pgw.getValue()
					,	byr_pgw_hon				: this.form_byr_pgw_hon.getValue()
					,	byr_pgw_kesra			: this.form_byr_pgw_kesra.getValue()
					,	byr_pbm					: this.form_byr_pbm.getValue()
					,	byr_gedung				: this.form_byr_gedung.getValue()
					,	byr_alat				: this.form_byr_alat.getValue()
					,	byr_perabot				: this.form_byr_perabot.getValue()
					,	byr_rehab				: this.form_byr_rehab.getValue()
					,	byr_buku				: this.form_byr_buku.getValue()
					,	byr_ada_lain			: this.form_byr_ada_lain.getValue()
					,	byr_eks_kul				: this.form_byr_eks_kul.getValue()
					,	byr_daya_jasa			: this.form_byr_daya_jasa.getValue()
					,	byr_tu_adm				: this.form_byr_tu_adm.getValue()
					,	byr_lain				: this.form_byr_lain.getValue()
					,	saldo_akhir				: this.form_saldo_akhir.getValue()
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_keuangan_sekolah.jsp'
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
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_keuangan_sekolah.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 1) {
			this.btn_save.setDisabled(false);
		} else {
			this.btn_save.setDisabled(true);
		}
	
		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahBantuanSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_bantuan' }
		,	{ name	: 'kd_bantuan_old' }
		,	{ name	: 'tahun_bantuan' }
		,	{ name	: 'sumber_bantuan' }
		,	{ name	: 'sumber_bantuan_old' }
		,	{ name	: 'jumlah_dana' }
		,	{ name	: 'dana_pendamping' }
		,	{ name	: 'peruntukan_dana' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_bantuan_sekolah.jsp'
		,	autoLoad	: false
	});
	
	this.store_kd_bantuan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_ref_bantuan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	/* form items */
	this.form_kd_bantuan = new Ext.form.ComboBox({
			store			: this.store_kd_bantuan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_sumber_bantuan = new Ext.form.TextField({
		allowBlank	: false
	});

	this.form_jumlah_dana = new Ext.ux.NumericField({
			allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
	});

	this.form_dana_pendamping = new Ext.ux.NumericField({
			allowBlank				: false
		,	allowDecimals			: true
		,	allowNegative			: false
		,	alwaysDisplayDecimals	: true
	});

	this.form_peruntukan_dana = new Ext.form.TextField({
		allowBlank	: false
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Jenis Bantuan'
			, dataIndex		: 'kd_bantuan'
			, sortable		: true
			, editor		: this.form_kd_bantuan
			, renderer		: combo_renderer(this.form_kd_bantuan)
			, width			: 180
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_bantuan
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Sumber Bantuan'
			, dataIndex		: 'sumber_bantuan'
			, sortable		: true
			, editor		: this.form_sumber_bantuan
			, width			: 250
			, filterable	: true
			}
		,	{ header		: 'Jumlah Dana'
			, dataIndex		: 'jumlah_dana'
			, sortable		: true
			, editor		: this.form_jumlah_dana
			, align			: 'right'
			, width			: 150
			, filter		: {
				type		: 'numeric'
			}
			}
		,	{ header		: 'Dana Pendamping'
			, dataIndex		: 'dana_pendamping'
			, sortable		: true
			, editor		: this.form_dana_pendamping
			, align			: 'right'
			, width			: 150
			, filter		: {
				type		: 'numeric'
			}
			}
		,	{ id			: 'peruntukan_dana'
			, header		: 'Peruntukan Dana'
			, dataIndex		: 'peruntukan_dana'
			, sortable		: true
			, editor		: this.form_peruntukan_dana
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level == 4) {
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
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'peruntukan_dana'
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
		this.record_new = new this.record({
				kd_bantuan		: ''
			,	tahun_bantuan	: ''
			,	sumber_bantuan	: ''
			,	jumlah_dana		: ''
			,	dana_pendamping	: ''
			,	peruntukan_dana	: ''
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
		
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						kd_bantuan			: record.data['kd_bantuan']
					,	kd_bantuan_old		: record.data['kd_bantuan_old']
					,	tahun_bantuan		: record.data['tahun_bantuan']
					,	sumber_bantuan		: record.data['sumber_bantuan']
					,	sumber_bantuan_old	: record.data['sumber_bantuan_old']
					,	jumlah_dana			: record.data['jumlah_dana']
					,	dana_pendamping		: record.data['dana_pendamping']
					,	peruntukan_dana		: record.data['peruntukan_dana']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_bantuan_sekolah.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_kd_bantuan.load({
				callback	: function(){
					this.store.load();
				}
			,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolahRekeningSekolah(title)
{
	this.title		= title;
	this.dml_type	= 0;

	/* record */
	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'nm_rek' }
		,	{ name	: 'no_rek_sekolah' }
		,	{ name	: 'nm_bank' }
		,	{ name	: 'cabang_bank' }
	]);

	/* store */
	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_rekening_sekolah.jsp'
		,	autoLoad	: false
	});
	
	/* form items */
	this.form_no_urut = new Ext.form.NumberField({
			allowBlank				: false
		,	allowDecimals			: false
		,	allowNegative			: false
	});

	this.form_nm_rek = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_no_rek_sekolah = new Ext.form.NumberField({
			allowBlank				: false
		,	allowDecimals			: false
		,	allowNegative			: false
	});

	this.form_nm_bank = new Ext.form.TextField({
			allowBlank	: false
	});

	this.form_cabang_bank = new Ext.form.TextField({
			allowBlank	: false
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'No Urut'
			, dataIndex		: 'no_urut'
			, sortable		: true
			, editor		: this.form_no_urut
			, align			: 'center'
			, width			: 60
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Nama Rekening'
			, dataIndex		: 'nm_rek'
			, sortable		: true
			, editor		: this.form_nm_rek
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'No.Rekening'
			, dataIndex		: 'no_rek_sekolah'
			, sortable		: true
			, editor		: this.form_no_rek_sekolah
			, width			: 150
			, filterable	: true
			}
		,	{ header		: 'Nama Bank'
			, dataIndex		: 'nm_bank'
			, sortable		: true
			, editor		: this.form_nm_bank
			, width			: 200
			, filterable	: true
			}
		,	{ id			: 'cabang_bank'
			, header		: 'Cabang Bank'
			, dataIndex		: 'cabang_bank'
			, sortable		: true
			, editor		: this.form_cabang_bank
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level == 4) {
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
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'cabang_bank'
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
		this.record_new = new this.record({
				no_urut			: ''
			,	nm_rek			: ''
			,	no_rek_sekolah	: ''
			,	nm_bank			: ''
			,	cabang_bank		: ''
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
		
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						no_urut			: record.data['no_urut']
					,	no_urut_old		: record.data['no_urut_old']
					,	nm_rek			: record.data['nm_rek']
					,	no_rek_sekolah	: record.data['no_rek_sekolah']
					,	nm_bank			: record.data['nm_bank']
					,	cabang_bank		: record.data['cabang_bank']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'submit_rekening_sekolah.jsp'
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
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store.load();
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPemeliharaanIdentitasSekolah()
{
	m_adm_sekolah_pemeliharaan_identitas_sekolah_informasi_sekolah			= new M_AdmSekolahPemeliharaanIdentitasSekolahInformasiSekolah('Informasi Sekolah');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_kumpulan_sk				= new M_AdmSekolahPemeliharaanIdentitasSekolahKumpulanSK('Kumpulan SK');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_yayasan					= new M_AdmSekolahPemeliharaanIdentitasSekolahYayasan('Yayasan');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_penggunaan_laboratorium	= new M_AdmSekolahPemeliharaanIdentitasSekolahPenggunaanLaboratorium('Penggunaan Laboratorium');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_psb						= new M_AdmSekolahPemeliharaanIdentitasSekolahPSB('PSB');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_nilai_un					= new M_AdmSekolahPemeliharaanIdentitasSekolahNilaiUN('Nilai UN');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_keuangan_sekolah			= new M_AdmSekolahPemeliharaanIdentitasSekolahKeuanganSekolah('Keuangan Sekolah');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_bantuan_sekolah			= new M_AdmSekolahPemeliharaanIdentitasSekolahBantuanSekolah('Bantuan Sekolah');
	m_adm_sekolah_pemeliharaan_identitas_sekolah_rekening_sekolah			= new M_AdmSekolahPemeliharaanIdentitasSekolahRekeningSekolah('Rekening Sekolah');

	this.panel = new Ext.TabPanel({
			id				: 'adm_sekolah_pemeliharaan_identitas_sekolah_panel'
		,	enableTabScroll	: true
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animScroll		: true
    		}
		,	items			: [
				m_adm_sekolah_pemeliharaan_identitas_sekolah_informasi_sekolah.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_kumpulan_sk.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_yayasan.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_penggunaan_laboratorium.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_psb.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_nilai_un.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_keuangan_sekolah.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_bantuan_sekolah.panel
			,	m_adm_sekolah_pemeliharaan_identitas_sekolah_rekening_sekolah.panel
			]
	});
	
	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_pemeliharaan_identitas_sekolah_d +'data_ref_sekolah.jsp'
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
				
				if (msg.kd_status_sekolah == '1'){
					this.panel.getItem(2).setDisabled(true);
				}
			}
		,	scope	: this		
		});
	}
	
	this.do_refresh = function(ha_level)
	{
		m_adm_sekolah_pemeliharaan_identitas_sekolah_ha_level = ha_level;
		
		m_adm_sekolah_pemeliharaan_identitas_sekolah_informasi_sekolah.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_kumpulan_sk.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_yayasan.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_penggunaan_laboratorium.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_psb.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_nilai_un.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_keuangan_sekolah.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_bantuan_sekolah.do_refresh();
		m_adm_sekolah_pemeliharaan_identitas_sekolah_rekening_sekolah.do_refresh();
		
		this.do_check();
	}
}

m_adm_sekolah_pemeliharaan_identitas_sekolah = new M_AdmSekolahPemeliharaanIdentitasSekolah();

//@ sourceURL=adm_sekolah_pemeliharaan_identitas_sekolah.layout.js
