/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_sekolah_praktek_keterampilan_hidup;
var m_adm_sekolah_praktek_keterampilan_hidup_guru_pkh;
var m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh;
var m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_list;
var m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail;
var m_adm_sekolah_praktek_keterampilan_hidup_mitra_pkh;
var m_adm_sekolah_praktek_keterampilan_hidup_alat_pkh;
var m_adm_sekolah_praktek_keterampilan_hidup_kegiatan_pkh;
var m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_no_urut = '';
var m_adm_sekolah_praktek_keterampilan_hidup_d = _g_root +'/module/adm_sekolah_praktek_keterampilan_hidup/';
var m_adm_sekolah_praktek_keterampilan_hidup_ha_level = 0;

function M_AdmSekolahPraktekKeterampilanHidupGuruPKH(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'id_pegawai' }
		,	{ name	: 'id_pegawai_old' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_guru_pkh.jsp'
		,	autoLoad	: false
	});
	
	this.store_pegawai = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_pegawai.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_pegawai = new Ext.form.ComboBox({
			store			: this.store_pegawai
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

	this.form_keterangan = new Ext.form.TextField({});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Nama Guru'
			, dataIndex		: 'id_pegawai'
			, sortable		: true
			, editor		: this.form_pegawai
			, renderer		: combo_renderer(this.form_pegawai)
			, width			: 300
			, filter		: {
					type		: 'list'
				,	store		: this.store_pegawai
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
					if (data.length && m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
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
		this.record_new = new this.record({
				id_pegawai	: ''
			,	keterangan	: ''
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
		
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_pegawai		: record.data['id_pegawai']
					,	id_pegawai_old	: record.data['id_pegawai_old']
					,	keterangan		: record.data['keterangan']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'submit_guru_pkh.jsp'
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_pegawai.load({
			callback	: function(){
				this.store.load();
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPraktekKeterampilanHidupNarasumberPKHDetail()
{
	this.dml_type	= 0;

	this.store_tingkat_ijazah = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_tingkat_ijazah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_program_studi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_program_studi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_gol_pekerjaan = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_gol_pekerjaan.jsp'
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

	this.form_nm_narasumber = new Ext.form.TextField({
			fieldLabel		: 'Nama Narasumber'
		,	allowBlank		: false
		,	width			: 400
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
		,	width			: 300
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
		,	width			: 300
		,	msgTarget		: 'side'
	});

	this.form_gol_pekerjaan = new Ext.form.ComboBox({
			fieldLabel		: 'Gol.Pekerjaan'
		,	store			: this.store_gol_pekerjaan
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	width			: 300
		,	msgTarget		: 'side'
	});

	this.form_bidang_keahlian = new Ext.form.TextField({
			fieldLabel		: 'Bidang Keahlian'
		,	allowBlank		: false
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.form_sedia_waktu = new Ext.form.NumberField({
			fieldLabel		: 'Sedia Waktu'
		,	allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
		,	width			: 100
		,	msgTarget		: 'side'
	});

	this.form_keterangan = new Ext.form.TextArea({
			fieldLabel		: 'Keterangan'
		,	width			: 400
		,	msgTarget		: 'side'
	});

	this.panel_form = new Ext.form.FormPanel({
			labelAlign		: 'right'
		,	labelWidth		: 150
		,	autoWidth		: true
		,	autoHeight		: true
		,	style			: 'margin: 8px;'
		,	bodyCssClass	: 'stop-panel-form'
		,	items			: [
					this.form_no_urut
				,	this.form_nm_narasumber
				,	this.form_tanggal_lahir
				,	this.form_tingkat_ijazah
				,	this.form_program_studi
				,	this.form_gol_pekerjaan
				,	this.form_bidang_keahlian
				,	this.form_sedia_waktu
				,	this.form_keterangan
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
		this.form_nm_narasumber.setValue('');
		this.form_tanggal_lahir.setValue('');
		this.form_tingkat_ijazah.setValue('');
		this.form_program_studi.setValue('');
		this.form_gol_pekerjaan.setValue('');
		this.form_bidang_keahlian.setValue('');
		this.form_sedia_waktu.setValue('');
		this.form_keterangan.setValue('');
	}

	this.edit_fill_form = function(data)
	{
		this.form_no_urut.setValue(data.no_urut);
		this.form_nm_narasumber.setValue(data.nm_narasumber);
		this.form_tanggal_lahir.setValue(data.tanggal_lahir);
		this.form_tingkat_ijazah.setValue(data.kd_tingkat_ijazah);
		this.form_program_studi.setValue(data.kd_program_studi);
		this.form_gol_pekerjaan.setValue(data.id_gol_pekerjaan_ortu);
		this.form_bidang_keahlian.setValue(data.bidang_keahlian);
		this.form_sedia_waktu.setValue(data.sedia_waktu);
		this.form_keterangan.setValue(data.keterangan);
		
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
			url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_narasumber_pkh.jsp'
		,	params	: {
				no_urut	: m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_no_urut
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
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh.panel.layout.setActiveItem(0);
	}

	this.is_valid = function()
	{
		if (!this.form_no_urut.isValid()) {
			return false;
		}

		if (!this.form_nm_narasumber.isValid()) {
			return false;
		}

		if (!this.form_tanggal_lahir.isValid()) {
			return false;
		}

		if (!this.form_tingkat_ijazah.isValid()) {
			return false;
		}

		if (!this.form_program_studi.isValid()) {
			return false;
		}

		if (!this.form_gol_pekerjaan.isValid()) {
			return false;
		}

		if (!this.form_bidang_keahlian.isValid()) {
			return false;
		}

		if (!this.form_sedia_waktu.isValid()) {
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
				url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'submit_narasumber_pkh.jsp'
			,	params  : {
						no_urut					: this.form_no_urut.getValue()
					,	nm_narasumber			: this.form_nm_narasumber.getValue()
					,	tanggal_lahir			: this.form_tanggal_lahir.getValue()
					,	kd_tingkat_ijazah		: this.form_tingkat_ijazah.getValue()
					,	kd_program_studi		: this.form_program_studi.getValue()
					,	id_gol_pekerjaan_ortu	: this.form_gol_pekerjaan.getValue()
					,	bidang_keahlian			: this.form_bidang_keahlian.getValue()
					,	sedia_waktu				: this.form_sedia_waktu.getValue()
					,	keterangan				: this.form_keterangan.getValue()
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

						m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_list.store.reload();
						m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh.panel.layout.setActiveItem(0);
					}
			,	scope	: this
		});
	}

	this.do_refresh = function()
	{
		this.store_tingkat_ijazah.load();
		this.store_program_studi.load();
		this.store_gol_pekerjaan.load();
	}
}

function M_AdmSekolahPraktekKeterampilanHidupNarasumberPKHList()
{
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'nm_narasumber' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_narasumber_pkh_list.jsp'
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
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_urut'
			, align			: 'center'
			, width			: 70
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Nama Narasumber'
			, dataIndex		: 'nm_narasumber'
			, width			: 300
			, filterable	: true
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
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
						m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_no_urut = data[0].data['no_urut'];
						
						if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
							this.btn_del.setDisabled(false);
						}
					} else {
						m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_no_urut = '';
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
		,	autoExpandColumn	: 'keterangan'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				Ext.Ajax.request({
					url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'submit_narasumber_pkh.jsp'
				,	params	: {
						dml_type				: 4
					,	no_urut					: data.get('no_urut')
					,	nm_narasumber			: ''
					,	tanggal_lahir			: ''
					,	kd_tingkat_ijazah		: ''
					,	kd_program_studi		: ''
					,	id_gol_pekerjaan_ortu	: ''
					,	bidang_keahlian			: ''
					,	sedia_waktu				: ''
					,	keterangan				: ''
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
		var data = this.sm.getSelected();

		if (data == undefined) {
			return;
		}

		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail.do_refresh();
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail.do_edit(data.get('no_urut'));
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh.panel.layout.setActiveItem(1);
	}

	this.do_add = function()
	{
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail.do_refresh();
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail.do_add();
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh.panel.layout.setActiveItem(1);
	}
	
	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 3) {
			this.btn_edit.setDisabled(true);
		} else {
			this.btn_edit.setDisabled(false);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		this.do_load();
	}
}

function M_AdmSekolahPraktekKeterampilanHidupNarasumberPKH(title)
{
	m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_list	= new M_AdmSekolahPraktekKeterampilanHidupNarasumberPKHList();
	m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail	= new M_AdmSekolahPraktekKeterampilanHidupNarasumberPKHDetail();
	
	this.panel = new Ext.Panel({
			title			: title
		,	layout			: 'card'
		,	activeItem		: 0
		,	autoWidth		: true
		,	autoScroll		: true
		,	items			: [
				m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_list.panel
			,	m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_detail.panel
			]
	});
	
	this.do_refresh = function()
	{
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh_list.do_refresh();
	}
}

function M_AdmSekolahPraktekKeterampilanHidupMitraPKH(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'nm_mitra' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_mitra_pkh.jsp'
		,	autoLoad	: false
	});
	
	this.form_no_urut = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_nm_mitra = new Ext.form.TextField({
			allowBlank		: false
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
			, width			: 70
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Nama Mitra'
			, dataIndex		: 'nm_mitra'
			, sortable		: true
			, editor		: this.form_nm_mitra
			, width			: 300
			, filterable	: true
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
					if (data.length && m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
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
		this.record_new = new this.record({
				no_urut		: ''
			,	nm_mitra	: ''
			,	keterangan	: ''
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
		
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						no_urut		: record.data['no_urut']
					,	no_urut_old	: record.data['no_urut_old']
					,	nm_mitra	: record.data['nm_mitra']
					,	keterangan	: record.data['keterangan']
					,	dml_type	: this.dml_type
				}
			,	url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'submit_mitra_pkh.jsp'
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPraktekKeterampilanHidupAlatPKH(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'nm_alat' }
		,	{ name	: 'jumlah_baik' }
		,	{ name	: 'jumlah_ringan' }
		,	{ name	: 'jumlah_sedang' }
		,	{ name	: 'jumlah_berat' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_alat_pkh.jsp'
		,	autoLoad	: false
	});
	
	this.form_no_urut = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_nm_alat = new Ext.form.TextField({
			allowBlank		: false
	});
	
	this.form_jumlah_baik = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_jumlah_ringan = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_jumlah_sedang = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_jumlah_berat = new Ext.form.NumberField({
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
		,	{ header		: 'No.Urut'
			, dataIndex		: 'no_urut'
			, sortable		: true
			, editor		: this.form_no_urut
			, align			: 'center'
			, width			: 70
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ id			: 'nm_alat'
			, header		: 'Nama Alat'
			, dataIndex		: 'nm_alat'
			, sortable		: true
			, editor		: this.form_nm_alat
			, filterable	: true
			}
		,	{ header		: 'Baik'
			, dataIndex		: 'jumlah_baik'
			, sortable		: true
			, editor		: this.form_jumlah_baik
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Rusak Ringan'
			, dataIndex		: 'jumlah_ringan'
			, sortable		: true
			, editor		: this.form_jumlah_ringan
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Rusak Sedang'
			, dataIndex		: 'jumlah_sedang'
			, sortable		: true
			, editor		: this.form_jumlah_sedang
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Rusak Berat'
			, dataIndex		: 'jumlah_berat'
			, sortable		: true
			, editor		: this.form_jumlah_berat
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
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
		,	autoExpandColumn: 'nm_alat'
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
			,	nm_alat			: ''
			,	jumlah_baik		: ''
			,	jumlah_ringan	: ''
			,	jumlah_sedang	: ''
			,	jumlah_berat	: ''
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
		
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						no_urut			: record.data['no_urut']
					,	no_urut_old		: record.data['no_urut_old']
					,	nm_alat			: record.data['nm_alat']
					,	jumlah_baik		: record.data['jumlah_baik']
					,	jumlah_ringan	: record.data['jumlah_ringan']
					,	jumlah_sedang	: record.data['jumlah_sedang']
					,	jumlah_berat	: record.data['jumlah_berat']
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'submit_alat_pkh.jsp'
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPraktekKeterampilanHidupKegiatanPKH(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'no_urut' }
		,	{ name	: 'no_urut_old' }
		,	{ name	: 'id_jenis_pkh' }
		,	{ name	: 'tahun_awal' }
		,	{ name	: 'jumlah' }
		,	{ name	: 'kd_hasil_evaluasi' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_kegiatan_pkh.jsp'
		,	autoLoad	: false
	});
	
	this.store_jenis_pkh = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_jenis_pkh.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_hasil_evaluasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_hasil_evaluasi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_no_urut = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_jenis_pkh = new Ext.form.ComboBox({
			store			: this.store_jenis_pkh
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_tahun_awal = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_jumlah_peserta = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: true
		,	allowNegative	: false
	});

	this.form_hasil_evaluasi = new Ext.form.ComboBox({
			store			: this.store_hasil_evaluasi
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
			, width			: 70
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Jenis PKH'
			, dataIndex		: 'id_jenis_pkh'
			, sortable		: true
			, editor		: this.form_jenis_pkh
			, renderer		: combo_renderer(this.form_jenis_pkh)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_jenis_pkh
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tahun Awal'
			, dataIndex		: 'tahun_awal'
			, sortable		: true
			, editor		: this.form_tahun_awal
			, align			: 'center'
			, width			: 80
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Jumlah Peserta'
			, dataIndex		: 'jumlah'
			, sortable		: true
			, editor		: this.form_jumlah_peserta
			, align			: 'center'
			, width			: 100
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ header		: 'Hasil Evaluasi'
			, dataIndex		: 'kd_hasil_evaluasi'
			, sortable		: true
			, editor		: this.form_hasil_evaluasi
			, renderer		: combo_renderer(this.form_hasil_evaluasi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_hasil_evaluasi
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
					if (data.length && m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
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
		this.record_new = new this.record({
				no_urut				: ''
			,	id_jenis_pkh		: ''
			,	tahun_awal			: ''
			,	jumlah				: ''
			,	kd_hasil_evaluasi	: ''
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
		
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						no_urut				: record.data['no_urut']
					,	no_urut_old			: record.data['no_urut_old']
					,	id_jenis_pkh		: record.data['id_jenis_pkh']
					,	tahun_awal			: record.data['tahun_awal']
					,	jumlah				: record.data['jumlah']
					,	kd_hasil_evaluasi	: record.data['kd_hasil_evaluasi']
					,	keterangan			: record.data['keterangan']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'submit_kegiatan_pkh.jsp'
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_jenis_pkh.load({
			callback	: function(){
				this.store_hasil_evaluasi.load({
					callback	: function() {
						this.store.load();
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
		if (m_adm_sekolah_praktek_keterampilan_hidup_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPraktekKeterampilanHidup()
{
	m_adm_sekolah_praktek_keterampilan_hidup_guru_pkh		= new M_AdmSekolahPraktekKeterampilanHidupGuruPKH('Guru PKH');
	m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh	= new M_AdmSekolahPraktekKeterampilanHidupNarasumberPKH('Narasumber PKH');
	m_adm_sekolah_praktek_keterampilan_hidup_mitra_pkh		= new M_AdmSekolahPraktekKeterampilanHidupMitraPKH('Mitra PKH');
	m_adm_sekolah_praktek_keterampilan_hidup_alat_pkh		= new M_AdmSekolahPraktekKeterampilanHidupAlatPKH('Alat PKH');
	m_adm_sekolah_praktek_keterampilan_hidup_kegiatan_pkh	= new M_AdmSekolahPraktekKeterampilanHidupKegiatanPKH('Kegiatan PKH');

	this.panel = new Ext.TabPanel({
			id				: 'adm_sekolah_praktek_keterampilan_hidup_panel'
		,	enableTabScroll	: true
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animScroll		: true
    		}
		,	items			: [
				m_adm_sekolah_praktek_keterampilan_hidup_guru_pkh.panel
			,	m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh.panel
			,	m_adm_sekolah_praktek_keterampilan_hidup_mitra_pkh.panel
			,	m_adm_sekolah_praktek_keterampilan_hidup_alat_pkh.panel
			,	m_adm_sekolah_praktek_keterampilan_hidup_kegiatan_pkh.panel
			]
	});
	
	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_praktek_keterampilan_hidup_d +'data_ref_sekolah.jsp'
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
		m_adm_sekolah_praktek_keterampilan_hidup_ha_level = ha_level;
		
		m_adm_sekolah_praktek_keterampilan_hidup_guru_pkh.do_refresh();
		m_adm_sekolah_praktek_keterampilan_hidup_narasumber_pkh.do_refresh();
		m_adm_sekolah_praktek_keterampilan_hidup_mitra_pkh.do_refresh();
		m_adm_sekolah_praktek_keterampilan_hidup_alat_pkh.do_refresh();
		m_adm_sekolah_praktek_keterampilan_hidup_kegiatan_pkh.do_refresh();
		
		this.do_check();
	}
}

m_adm_sekolah_praktek_keterampilan_hidup = new M_AdmSekolahPraktekKeterampilanHidup();

//@ sourceURL=adm_sekolah_praktek_keterampilan_hidup.layout.js
