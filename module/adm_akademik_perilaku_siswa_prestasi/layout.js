/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_akademik_perilaku_siswa_prestasi;
var m_adm_akademik_perilaku_siswa_prestasi_master;
var m_adm_akademik_perilaku_siswa_prestasi_detail;
var m_adm_akademik_perilaku_siswa_prestasi_d = _g_root +'/module/adm_akademik_perilaku_siswa_prestasi/';
var m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran = '';
var m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas = '';
var m_adm_akademik_perilaku_siswa_prestasi_kd_rombel = '';
var m_adm_akademik_perilaku_siswa_prestasi_ha_level = 0;

function m_adm_akademik_perilaku_siswa_prestasi_master_on_select_load_detail()
{
 	if (typeof m_adm_akademik_perilaku_siswa_prestasi_master == 'undefined'
	||  typeof m_adm_akademik_perilaku_siswa_prestasi_detail == 'undefined'
	||	m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran == ''
	||	m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas == ''
	||	m_adm_akademik_perilaku_siswa_prestasi_kd_rombel == '') {
		return;
	}

	m_adm_akademik_perilaku_siswa_prestasi_detail.do_refresh();
}

function M_AdmAkademikPerilakuSiswaPrestasiMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_pegawai' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'id_ruang_kelas' }
		,	{ name	: 'nm_ruang_kelas' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_perilaku_siswa_prestasi_d +'data_master.jsp'
		,	autoLoad	: false
	});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Rombel'
			, dataIndex		: 'kd_rombel'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Wali Kelas'
			, dataIndex		: 'nm_pegawai'
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Ruang Kelas'
			, dataIndex		: 'nm_ruang_kelas'
			, width			: 100
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
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran	= data[0].data['kd_tahun_ajaran'];
							m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas	= data[0].data['kd_tingkat_kelas'];
							m_adm_akademik_perilaku_siswa_prestasi_kd_rombel		= data[0].data['kd_rombel'];
						} else {
							m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran	= '';
							m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas	= '';
							m_adm_akademik_perilaku_siswa_prestasi_kd_rombel	= '';
						}

						m_adm_akademik_perilaku_siswa_prestasi_master_on_select_load_detail();
					}
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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'keterangan'
	});

	this.do_load = function()
	{
		this.store.load();

		m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran	= '';
		m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas	= '';
		m_adm_akademik_perilaku_siswa_prestasi_kd_rombel		= '';
		
		m_adm_akademik_perilaku_siswa_prestasi_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_adm_akademik_perilaku_siswa_prestasi_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmAkademikPerilakuSiswaPrestasiDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_siswa' }
		,	{ name	: 'id_siswa_old' }
		,	{ name	: 'id_jenis_lomba' }
		,	{ name	: 'id_jenis_lomba_old' }
		,	{ name	: 'kd_tingkat_prestasi' }
		,	{ name	: 'kd_tingkat_prestasi_old' }
		,	{ name	: 'tanggal_prestasi' }
		,	{ name	: 'tanggal_prestasi_old' }
		,	{ name	: 'juara_ke' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_perilaku_siswa_prestasi_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.store_ref_siswa = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_akademik_perilaku_siswa_prestasi_d +'data_ref_siswa.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_ref_jenis_lomba = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_akademik_perilaku_siswa_prestasi_d +'data_ref_jenis_lomba.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_ref_tingkat_prestasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_akademik_perilaku_siswa_prestasi_d +'data_ref_tingkat_prestasi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_siswa = new Ext.form.ComboBox({
			store			: this.store_ref_siswa
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

	this.form_jenis_lomba = new Ext.form.ComboBox({
			store			: this.store_ref_jenis_lomba
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

	this.form_tingkat_prestasi = new Ext.form.ComboBox({
			store			: this.store_ref_tingkat_prestasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_tanggal_prestasi = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_juara_ke = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_keterangan = new Ext.form.TextField({});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Nama Siswa'
			, dataIndex		: 'id_siswa'
			, sortable		: true
			, editor		: this.form_siswa
			, renderer		: combo_renderer(this.form_siswa)
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Jenis Lomba'
			, dataIndex		: 'id_jenis_lomba'
			, sortable		: true
			, editor		: this.form_jenis_lomba
			, renderer		: combo_renderer(this.form_jenis_lomba)
			, width			: 200
			, filter		: {
					type		: 'list'
				,	store		: this.store_ref_jenis_lomba
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tingkat Prestasi'
			, dataIndex		: 'kd_tingkat_prestasi'
			, sortable		: true
			, editor		: this.form_tingkat_prestasi
			, renderer		: combo_renderer(this.form_tingkat_prestasi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_ref_jenis_lomba
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tanggal Prestasi'
			, dataIndex		: 'tanggal_prestasi'
			, sortable		: true
			, editor		: this.form_tanggal_prestasi
			, align			: 'center'
			, width			: 120
			, filter		: {
					type		: 'date'
			 }
			}
		,	{ header		: 'Juara Ke'
			, dataIndex		: 'juara_ke'
			, sortable		: true
			, editor		: this.form_juara_ke
			, align			: 'center'
			, width			: 60
			, filter		: {
					type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_akademik_perilaku_siswa_prestasi_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
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
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.grid = new Ext.grid.GridPanel({
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
				,	rowclick	: function (g, r, e) {
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

	this.do_del = function()
	{
		if (m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran == ''
		||  m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas == ''
		||  m_adm_akademik_perilaku_siswa_prestasi_kd_rombel == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Wali Kelas terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}
	this.do_add = function()
	{
		if (m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran == ''
		||  m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas == ''
		||  m_adm_akademik_perilaku_siswa_prestasi_kd_rombel == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Wali Kelas terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				kd_tahun_ajaran		: ''
			,	kd_tingkat_kelas	: ''
			,	kd_rombel			: ''
			,	id_siswa			: ''
			,	id_jenis_lomba		: ''
			,	kd_tingkat_prestasi	: ''
			,	tanggal_prestasi	: ''
			,	juara_ke			: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_edit = function(row)
	{
		if (m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran == ''
		||  m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas == ''
		||  m_adm_akademik_perilaku_siswa_prestasi_kd_rombel == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Wali Kelas terlebih dahulu!");
			return;
		}

		if (m_adm_akademik_perilaku_siswa_prestasi_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
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
				url		: m_adm_akademik_perilaku_siswa_prestasi_d +'submit.jsp'
			,	params  : {
						kd_tahun_ajaran			: m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran
					,	kd_tingkat_kelas		: m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas
					,	kd_rombel				: m_adm_akademik_perilaku_siswa_prestasi_kd_rombel
					,	id_siswa				: record.data['id_siswa']
					,	id_siswa_old			: record.data['id_siswa_old']
					,	id_jenis_lomba			: record.data['id_jenis_lomba']
					,	id_jenis_lomba_old		: record.data['id_jenis_lomba_old']
					,	kd_tingkat_prestasi		: record.data['kd_tingkat_prestasi']
					,	kd_tingkat_prestasi_old	: record.data['kd_tingkat_prestasi_old']
					,	tanggal_prestasi		: record.data['tanggal_prestasi']
					,	tanggal_prestasi_old	: record.data['tanggal_prestasi_old']
					,	juara_ke				: record.data['juara_ke']
					,	keterangan				: record.data['keterangan']
					,	dml_type				: this.dml_type
				}
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

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.set_button = function()
	{
		if (m_adm_akademik_perilaku_siswa_prestasi_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_akademik_perilaku_siswa_prestasi_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_ref_siswa.load({
				params		: {
					kd_tahun_ajaran		: m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran
				,	kd_tingkat_kelas	: m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas
				,	kd_rombel			: m_adm_akademik_perilaku_siswa_prestasi_kd_rombel				
				}
			,	callback	: function(){
					this.store_ref_jenis_lomba.load({
							callback	: function(){
								this.store_ref_tingkat_prestasi.load({
									callback	: function(){
										this.store.load({
											params	: {
													kd_tahun_ajaran		: m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran
												,	kd_tingkat_kelas	: m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas
												,	kd_rombel			: m_adm_akademik_perilaku_siswa_prestasi_kd_rombel
											}
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

	this.do_refresh = function()
	{
		if (m_adm_akademik_perilaku_siswa_prestasi_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}

}

function M_AdmAkademikPerilakuSiswaPrestasi()
{
	m_adm_akademik_perilaku_siswa_prestasi_master	= new M_AdmAkademikPerilakuSiswaPrestasiMaster('Wali Kelas');
	m_adm_akademik_perilaku_siswa_prestasi_detail	= new M_AdmAkademikPerilakuSiswaPrestasiDetail('Prestasi Siswa');
	
	this.panel = new Ext.Panel({
			id			: 'adm_akademik_perilaku_siswa_prestasi_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_adm_akademik_perilaku_siswa_prestasi_master.grid
			,	m_adm_akademik_perilaku_siswa_prestasi_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_adm_akademik_perilaku_siswa_prestasi_ha_level	= ha_level;
		m_adm_akademik_perilaku_siswa_prestasi_kd_tahun_ajaran 	= '';
		m_adm_akademik_perilaku_siswa_prestasi_kd_tingkat_kelas = '';
		m_adm_akademik_perilaku_siswa_prestasi_kd_rombel 		= '';

		m_adm_akademik_perilaku_siswa_prestasi_master.do_refresh(ha_level);
	}

}

m_adm_akademik_perilaku_siswa_prestasi = new M_AdmAkademikPerilakuSiswaPrestasi();

//@ sourceURL=adm_akademik_perilaku_siswa_prestasi.layout.js
