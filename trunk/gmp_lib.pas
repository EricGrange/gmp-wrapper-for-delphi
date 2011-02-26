unit gmp_lib;

{
  GMP(MPIR) Library for Delphi.

  This wrapper only supports Delphi versions with operator overloading.
  For earlier versions please use header file gmp_lib.pas directly.
  This header file is based on MPIR v2.2.1. And MPIR v2.2.1 is based on GMP v5.0.1

  GMP Library: http://gmplib.org/
  MPIR Project: http://www.mpir.org/

  Author: wqyfavor
  Date: 2011.2
  Blog: hi.baidu.com/wqyfavor
  Email: wqyfavor@qq.com
  QQ: 466798985
  Tweet: t.qq.com/wqyfavor
}

interface

const
   MaxVarSize = MaxInt div 4;

const
   GMP_LIB_FILE = 'mpir.dll';

type
   mp_limb_t = Cardinal;
   mp_limb_signed_t = Integer;
   mp_bitcnt_t = Cardinal;

   mp_ptr = ^mp_limb_t;

   mp_size_t_p = ^mp_size_t;
   mp_size_t = Integer;
   mp_exp_t = Integer;

   // Prototype of arbitrary precision integer number
   pmpz_t = ^mpz_t;
   mpz_t = record
      mp_alloc: Integer;
      mp_size: Integer;
      mp_d: mp_ptr;
   end;

   mpz_array_ptr = ^mpz_array;
   mpz_array = array[0..MaxVarSize div SizeOf(mpz_t) - 1] of mpz_t;

   // Prototype of arbitrary precision rational number
   pmpq_t = ^mpq_t;
   mpq_t = record
      mp_num: mpz_t;
      mp_den: mpz_t;
   end;

   // Prototype of arbitrary precision float number
   pmpf_t = ^mpf_t;
   mpf_t = record
      mp_prec: Integer;
      mp_size: Integer;
      mp_exp: mp_exp_t;
      mp_d: mp_ptr;
   end;

{ Available random number generation algorithms. }
type
   gmp_randalg_t = (GMPRandAlgLC {Linear congruential}, GMPRandAlgMT{Mersenne Twister});

{ Linear congruential data struct. }
type
   gmp_randata_lc = record
      a: mpz_t; { Multiplier. }
      c: Cardinal; { Adder. }
      m: mpz_t; { Modulus (valid only if M2Exp = 0). }
      M2Exp: Cardinal; { If <> 0, modulus is 2 ^ M2Exp. }
   end;

type
   gmp_randstate_t = record
      Seed: mpz_t; { Current seed. }
      Alg: gmp_randalg_t; { Algorithm used. }
      AlgData: record { Algorithm specific data. }
         case gmp_randalg_t of
            GMPRandAlgLC: (lc: ^gmp_randata_lc) { Linear congruential. }
      end
   end;

{ Integer (i.e. Z) routines }

procedure mpz_init(var Dest: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_init';
procedure mpz_inits(p: pmpz_t {; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmpz_inits';
procedure mpz_init2(var Dest: mpz_t; N: mp_bitcnt_t); cdecl; varargs; external GMP_LIB_FILE name '__gmpz_init2';
procedure mpz_clear(var Dest: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_clear';
procedure mpz_clears(p: pmpz_t {; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmpz_clears';
function mpz_realloc(var Dest: mpz_t; Limbs: mp_size_t): Pointer; cdecl; external GMP_LIB_FILE name '__gmpz_realloc';
procedure mpz_realloc2(var Dest: mpz_t; Bits: mp_size_t); cdecl; external GMP_LIB_FILE name '__gmpz_realloc2';
procedure mpz_array_init(Dest: mpz_array_ptr; ArraySize, FixedNumBits: mp_size_t); cdecl; external GMP_LIB_FILE name '__gmpz_array_init';

procedure mpz_swap(var v1, v2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_swap';
procedure mpz_set(var Dest: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_set';
procedure mpz_set_ui(var Dest: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_set_ui';
procedure mpz_set_si(var Dest: mpz_t; Src: Integer); cdecl; external GMP_LIB_FILE name '__gmpz_set_si';
procedure mpz_set_uint64(var Dest: mpz_t; const Src: UInt64); // by delphi code
procedure mpz_set_int64(var Dest: mpz_t; const Src: Int64); // by delphi code
procedure mpz_set_d(var Dest: mpz_t; Src: Double); cdecl; external GMP_LIB_FILE name '__gmpz_set_d';
procedure mpz_set_q(var Dest: mpz_t; Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpz_set_q';
procedure mpz_set_f(var Dest: mpz_t; Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpz_set_f';
function mpz_set_str(var Dest: mpz_t; Src: PAnsiChar; Base: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_set_str';

procedure mpz_init_set(var Dest: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_init_set';
procedure mpz_init_set_ui(var Dest: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_init_set_ui';
procedure mpz_init_set_si(var Dest: mpz_t; Src: Integer); cdecl; external GMP_LIB_FILE name '__gmpz_init_set_si';
procedure mpz_init_set_d(var Dest: mpz_t; Src: Double); cdecl; external GMP_LIB_FILE name '__gmpz_init_set_d';
function mpz_init_set_str(var Dest: mpz_t; Src: PAnsiChar; Base: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_init_set_str';

procedure mpz_import(var Dest: mpz_t; Count: mp_size_t; Order: Integer; Size: mp_size_t; Endian: Integer; Nails: mp_size_t; op: Pointer); cdecl; external GMP_LIB_FILE name '__gmpz_import';
function mpz_export(Rop: Pointer; PCount: mp_size_t_p; Order: Integer; Size: mp_size_t; Endian: Integer; Nails: mp_size_t; var Src: mpz_t): Pointer; cdecl; external GMP_LIB_FILE name '__gmpz_export';

function mpz_getlimbn(var Src: mpz_t; n: mp_size_t): mp_limb_t; cdecl; external GMP_LIB_FILE name '__gmpz_getlimbn';
function mpz_size(var Src: mpz_t): mp_size_t; cdecl; external GMP_LIB_FILE name '__gmpz_size';

function mpz_get_ui(var Src: mpz_t): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_get_ui';
function mpz_get_si(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_get_si';
function mpz_get_d(var Src: mpz_t): Double; cdecl; external GMP_LIB_FILE name '__gmpz_get_d';
function mpz_get_d_2exp(var Exp: Integer; Src: mpz_t): Double; cdecl; external GMP_LIB_FILE name '__gmpz_get_d_2exp';
function mpz_fits_sint_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_fits_sint_p';
function mpz_fits_slong_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_fits_slong_p';
function mpz_fits_sshort_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_fits_sshort_p';
function mpz_fits_uint_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_fits_uint_p';
function mpz_fits_ulong_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_fits_ulong_p';
function mpz_fits_ushort_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_fits_ushort_p';
{ Pass nil for Dest to let the function allocate memory for it }
function mpz_get_str(Dest: PAnsiChar; Base: Integer; var Src: mpz_t): PAnsiChar; cdecl; external GMP_LIB_FILE name '__gmpz_get_str';

procedure mpz_add(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_add';
procedure mpz_add_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_add_ui';
procedure mpz_sub(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_sub';
procedure mpz_sub_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_sub_ui';
procedure mpz_ui_sub(var Dest: mpz_t; Src1: Cardinal; var Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_ui_sub';
procedure mpz_mul(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_mul';
procedure mpz_mul_si(var Dest: mpz_t; var Src1: mpz_t; Src2: Integer); cdecl; external GMP_LIB_FILE name '__gmpz_mul_si';
procedure mpz_mul_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_mul_ui';
procedure mpz_mul_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_mul_2exp';
procedure mpz_addmul(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_addmul';
procedure mpz_addmul_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_addmul_ui';
procedure mpz_submul(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_submul';
procedure mpz_submul_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_submul_ui';
procedure mpz_neg(var Dest: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_neg';
procedure mpz_abs(var Dest: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_abs';

procedure mpz_cdiv_q(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_q';
procedure mpz_cdiv_r(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_r';
procedure mpz_cdiv_qr(var DestQ, DestR: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_qr';
function mpz_cdiv_q_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_q_ui';
function mpz_cdiv_r_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_r_ui';
function mpz_cdiv_qr_ui(var DestQ, DestR: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_qr_ui';
function mpz_cdiv_ui(var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_ui';
procedure mpz_cdiv_q_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_q_2exp';
procedure mpz_cdiv_r_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_cdiv_r_2exp';

procedure mpz_fdiv_q(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_q';
procedure mpz_fdiv_r(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_r';
procedure mpz_fdiv_qr(var DestQ, DestR: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_qr';
function mpz_fdiv_q_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_q_ui';
function mpz_fdiv_r_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_r_ui';
function mpz_fdiv_qr_ui(var DestQ, DestR: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_qr_ui';
function mpz_fdiv_ui(var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_ui';
procedure mpz_fdiv_q_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_q_2exp';
procedure mpz_fdiv_r_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_fdiv_r_2exp';

procedure mpz_tdiv_q(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_q';
procedure mpz_tdiv_r(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_r';
procedure mpz_tdiv_qr(var DestQ, DestR: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_qr';
procedure mpz_tdiv_q_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_q_ui';
procedure mpz_tdiv_r_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_r_ui';
procedure mpz_tdiv_qr_ui(var DestQ, DestR: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_qr_ui';
function mpz_tdiv_ui(var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_ui';
procedure mpz_tdiv_q_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_q_2exp';
procedure mpz_tdiv_r_2exp(var Dest: mpz_t; var Src1: mpz_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_tdiv_r_2exp';

procedure mpz_mod(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_mod';
procedure mpz_mod_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_mod_ui';
procedure mpz_divexact(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_divexact';
procedure mpz_divexact_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_divexact_ui';

function mpz_divisible_p(var n, d: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_divisible_p';
function mpz_divisible_ui_p(var n: mpz_t; d: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_divisible_ui_p';
function mpz_divisible_2exp_p(var n: mpz_t; d: mp_bitcnt_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_divisible_2exp_p';
function mpz_congruent_p(var n, c, d: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_congruent_p';
function mpz_congruent_ui_p(var n: mpz_t; c, d: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_congruent_ui_p';
function mpz_congruent_2exp_p(var n, c: mpz_t; b: mp_bitcnt_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_congruent_2exp_p';

procedure mpz_powm(var Dest: mpz_t; var Base, Exponent, Modulus: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_powm';
procedure mpz_powm_ui(var Dest: mpz_t; var Base: mpz_t; Exponent: Cardinal; var Modulus: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_powm_ui';
procedure mpz_pow_ui(var Dest: mpz_t; var Base: mpz_t; Exponent: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_pow_ui';
procedure mpz_ui_pow_ui(var Dest: mpz_t; Base, Exponent: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_ui_pow_ui';

function mpz_root(var Dest: mpz_t; var Src: mpz_t; n: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_root';
procedure mpz_nthroot(var Dest: mpz_t; var Src: mpz_t; n: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_nthroot';
procedure mpz_rootrem(var Root: mpz_t; var Rem: mpz_t; var Src: mpz_t; n: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_rootrem';
procedure mpz_sqrt(var Dest: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_sqrt';
procedure mpz_sqrtrem(var Dest, DestR: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_sqrtrem';
function mpz_perfect_square_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_perfect_square_p';
function mpz_perfect_power_p(var Src: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_perfect_power_p';

function mpz_odd_p(var Src: mpz_t): Integer; inline;  // [MACRO]
function mpz_even_p(var Src: mpz_t): Integer; inline; // [MACRO]
function mpz_sizeinbase(var Src: mpz_t; Base: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_sizeinbase';

function mpz_probable_prime_p(var Src: mpz_t; var State: gmp_randstate_t; Prob: Integer; DivTested: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_probable_prime_p';
function mpz_likely_prime_p(var Src: mpz_t; var State: gmp_randstate_t; DivTested: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_likely_prime_p';
procedure mpz_next_likely_prime(var Dest: mpz_t; var Src: mpz_t; var State: gmp_randstate_t); cdecl; external GMP_LIB_FILE name '__gmpz_next_likely_prime';

// Number theoretic functions
procedure mpz_gcd(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_gcd';
function mpz_gcd_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_gcd_ui';
procedure mpz_gcdext(var Dest, DestA, DestB: mpz_t; var SrcA, SrcB: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_gcdext';
procedure mpz_lcm(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_lcm';
function mpz_lcm_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_lcm_ui';
function mpz_invert(var Dest: mpz_t; var Src, Modulus: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_invert';
function mpz_jacobi(var Src1, Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_jacobi';
function mpz_legendre(var Src1, Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_legendre';
function mpz_kronecker(var Src1, Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_kronecker';
function mpz_kronecker_si(var Src1: mpz_t; Src2: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_kronecker_si';
function mpz_kronecker_ui(var Src1: mpz_t; Src2: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_kronecker_ui';
function mpz_si_kronecker(Src1: Integer; var Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_si_kronecker';
function mpz_ui_kronecker(Src1: Cardinal; var Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_ui_kronecker';
function mpz_remove(var Dest: mpz_t; var Src1, Src2: mpz_t): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpz_remove';
procedure mpz_fac_ui(var Dest: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_fac_ui';
procedure mpz_fib_ui(var Dest: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_fib_ui';
procedure mpz_fib2_ui(var Dest: mpz_t; var DestSub: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_fib2_ui';
procedure mpz_bin_ui(var Dest: mpz_t; var Src1: mpz_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_bin_ui';
procedure mpz_bin_uiui(var Dest: mpz_t; Src1, Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_bin_uiui';
procedure mpz_lucnum_ui(var Dest: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_lucnum_ui';
procedure mpz_lucnum2_ui(var Dest: mpz_t; var DestSub: mpz_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_lucnum2_ui';

function mpz_sgn(var Src: mpz_t): Integer; // [MACRO]
function mpz_cmp(var Src1, Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmp';
function mpz_cmp_d(var Src1: mpz_t; Src2: Double): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmp_d';
function mpz_cmp_ui(var Src1: mpz_t; Src2: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmp_ui';
function mpz_cmp_si(var Src1: mpz_t; Src2: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmp_si';
function mpz_cmpabs(var Src1, Src2: mpz_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmpabs';
function mpz_cmpabs_d(var Src1: mpz_t; Src2: Double): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmpabs_d';
function mpz_cmpabs_ui(var Src1: mpz_t; Src2: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_cmpabs_ui';

procedure mpz_and(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_and';
procedure mpz_ior(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_ior';
procedure mpz_xor(var Dest: mpz_t; var Src1, Src2: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_xor';
procedure mpz_com(var Dest: mpz_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_com';
function mpz_popcount(var Src: mpz_t): mp_bitcnt_t; cdecl; external GMP_LIB_FILE name '__gmpz_popcount';
function mpz_hamdist(var Src1, Src2: mpz_t): mp_bitcnt_t; cdecl; external GMP_LIB_FILE name '__gmpz_hamdist';
function mpz_scan0(var Src: mpz_t; StartingBit: mp_bitcnt_t): mp_bitcnt_t; cdecl; external GMP_LIB_FILE name '__gmpz_scan0';
function mpz_scan1(var Src: mpz_t; StartingBit: mp_bitcnt_t): mp_bitcnt_t; cdecl; external GMP_LIB_FILE name '__gmpz_scan1';
procedure mpz_setbit(var Dest: mpz_t; BitIndex: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_setbit';
procedure mpz_clrbit(var Dest: mpz_t; BitIndex: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_clrbit';
procedure mpz_combit(var Dest: mpz_t; BitIndex: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpz_combit';
function mpz_tstbit(var Dest: mpz_t; BitIndex: mp_bitcnt_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpz_tstbit';

procedure mpz_urandomb(var ROP: mpz_t; var State: gmp_randstate_t; n: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_urandomb';
procedure mpz_urandomm(var ROP: mpz_t; var State: gmp_randstate_t; var n: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpz_urandomm';
procedure mpz_rrandomb(var ROP: mpz_t; var State: gmp_randstate_t; n: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpz_rrandomb';

{ Rational (i.e. Q) routines }

procedure mpq_canonicalize(var Dest: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_canonicalize';

procedure mpq_init(var Dest: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_init';
procedure mpq_inits(p: pmpq_t {; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmpq_inits';
procedure mpq_clear(var Dest: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_clear';
procedure mpq_clears(p: pmpq_t {; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmpq_clears';
procedure mpq_set(var Dest: mpq_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_set';
procedure mpq_set_z(var Dest: mpq_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpq_set_z';
procedure mpq_set_ui(var Dest: mpq_t; Nom, Den: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpq_set_ui';
procedure mpq_set_si(var Dest: mpq_t; Nom: Integer; Den: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpq_set_si';
function mpq_set_str(var Dest: mpq_t; Src: PAnsiChar; Base: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpq_set_str';
procedure mpq_set_d(var Dest: mpq_t; Src: Double); cdecl; external GMP_LIB_FILE name '__gmpq_set_d';
procedure mpq_set_f(var Dest: mpq_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpq_set_f';
procedure mpq_swap(var v1, v2: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_swap';

procedure mpq_add(var Dest: mpq_t; var Src1, Src2: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_add';
procedure mpq_sub(var Dest: mpq_t; var Src1, Src2: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_sub';
procedure mpq_mul(var Dest: mpq_t; var Src1, Src2: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_mul';
procedure mpq_div(var Dest: mpq_t; var Src1, Src2: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_div';
procedure mpq_neg(var Dest: mpq_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_neg';
procedure mpq_abs(var Dest: mpq_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_abs';
procedure mpq_inv(var Dest: mpq_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_inv';
procedure mpq_mul_2exp(var Dest: mpq_t; var Src1: mpq_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpq_mul_2exp';
procedure mpq_div_2exp(var Dest: mpq_t; var Src1: mpq_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpq_div_2exp';

function mpq_cmp(var Src1, Src2: mpq_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpq_cmp';
function mpq_cmp_ui(var Src1: mpq_t; Nom2, Den2: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpq_cmp_ui';
function mpq_cmp_si(var Src1: mpq_t; Nom2: Integer; Den2: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpq_cmp_si';
function mpq_sgn(var Src: mpq_t): Integer; // [MACRO]
function mpq_equal(var Src1, Src2: mpq_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpq_equal';

function mpq_numref(var Src: mpq_t): pmpz_t; inline; // [MACRO]
function mpq_denref(var Src: mpq_t): pmpz_t; inline; // [MACRO]
function mpq_get_d(var Src: mpq_t): Double; cdecl; external GMP_LIB_FILE name '__gmpq_get_d';
procedure mpq_set_num(var Dest: mpq_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpq_set_num';
procedure mpq_set_den(var Dest: mpq_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpq_set_den';
procedure mpq_get_num(var Dest: mpz_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_get_num';
procedure mpq_get_den(var Dest: mpz_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpq_get_den';

function mpq_get_str(Dest: PAnsiChar; Base: Integer; var Src: mpq_t): PAnsiChar; cdecl; external GMP_LIB_FILE name '__gmpq_get_str';

{ Floating point (i.e. R) routines }

procedure mpf_set_default_prec(Precision: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_set_default_prec';
function mpf_get_default_prec: mp_bitcnt_t; cdecl; external GMP_LIB_FILE name '__gmpf_get_default_prec';
procedure mpf_init(var Dest: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_init';
procedure mpf_init2(var Dest: mpf_t; Precision: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_init2';
procedure mpf_inits(p: pmpf_t {; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmpf_inits';
procedure mpf_clear(var Dest: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_clear';
procedure mpf_clears(p: pmpf_t {; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmpf_clears';
procedure mpf_set_prec(var Dest: mpf_t; Precision: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_set_prec';
function mpf_get_prec(var Src: mpf_t): mp_bitcnt_t; cdecl; external GMP_LIB_FILE name '__gmpf_get_prec';
procedure mpf_set_prec_raw(var Dest: mpf_t; Precision: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_set_prec_raw';

procedure mpf_set(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_set';
procedure mpf_set_ui(var Dest: mpf_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_set_ui';
procedure mpf_set_si(var Dest: mpf_t; Src: Integer); cdecl; external GMP_LIB_FILE name '__gmpf_set_si';
procedure mpf_set_d(var Dest: mpf_t; Src: Double); cdecl; external GMP_LIB_FILE name '__gmpf_set_d';
procedure mpf_set_z(var Dest: mpf_t; var Src: mpz_t); cdecl; external GMP_LIB_FILE name '__gmpf_set_z';
procedure mpf_set_q(var Dest: mpf_t; var Src: mpq_t); cdecl; external GMP_LIB_FILE name '__gmpf_set_q';
function mpf_set_str(var Dest: mpf_t; Src: PAnsiChar; Base: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_set_str';
procedure mpf_swap(var v1, v2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_swap';

procedure mpf_init_set(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_init_set';
procedure mpf_init_set_ui(var Dest: mpf_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_init_set_ui';
procedure mpf_init_set_si(var Dest: mpf_t; Src: Integer); cdecl; external GMP_LIB_FILE name '__gmpf_init_set_si';
procedure mpf_init_set_d(var Dest: mpf_t; Src: Double); cdecl; external GMP_LIB_FILE name '__gmpf_init_set_d';
function mpf_init_set_str(var Dest: mpf_t; Src: PAnsiChar; Base: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_init_set_str';

function mpf_get_d(var Src: mpf_t): Double; cdecl; external GMP_LIB_FILE name '__gmpf_get_d';
function mpf_get_si(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_get_si';
function mpf_get_ui(var Src: mpf_t): Cardinal; cdecl; external GMP_LIB_FILE name '__gmpf_get_ui';
function mpf_get_d_2exp(var Exp: Integer; var Src: mpf_t): Double; cdecl; external GMP_LIB_FILE name '__gmpf_get_d_2exp';
function mpf_fits_sint_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_fits_sint_p';
function mpf_fits_slong_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_fits_slong_p';
function mpf_fits_sshort_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_fits_sshort_p';
function mpf_fits_uint_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_fits_uint_p';
function mpf_fits_ulong_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_fits_ulong_p';
function mpf_fits_ushort_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_fits_ushort_p';

function mpf_cmp(var Src1, Src2: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_cmp';
function mpf_cmp_si(var Src1: mpf_t; Src2: Integer): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_cmp_si';
function mpf_cmp_ui(var Src1: mpf_t; Src2: Cardinal): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_cmp_ui';
function mpf_cmp_d(var Src1: mpf_t; Src2: Double): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_cmp_d';
function mpf_eq(var Src1, Src2: mpf_t; NumberOfBits: mp_bitcnt_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_eq';
procedure mpf_reldiff(var Dest: mpf_t; var Src1, Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_reldiff';
function mpf_sgn(var Src: mpf_t): Integer; // [MACRO]

{ Pass nil for Dest to let the function allocate memory for it }
function mpf_get_str(Dest: PAnsiChar; var Exponent: mp_exp_t; Base: Integer;
   NumberOfDigits: mp_size_t; var Src: mpf_t): PAnsiChar; cdecl; external GMP_LIB_FILE name '__gmpf_get_str';

procedure mpf_add(var Dest: mpf_t; var Src1, Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_add';
procedure mpf_add_ui(var Dest: mpf_t; var Src1: mpf_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_add_ui';
procedure mpf_sub(var Dest: mpf_t; var Src1, Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_sub';
procedure mpf_ui_sub(var Dest: mpf_t; Src1: Cardinal; var Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_ui_sub';
procedure mpf_sub_ui(var Dest: mpf_t; var Src1: mpf_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_sub_ui';
procedure mpf_mul(var Dest: mpf_t; var Src1, Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_mul';
procedure mpf_mul_ui(var Dest: mpf_t; var Src1: mpf_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_mul_ui';
procedure mpf_div(var Dest: mpf_t; var Src1, Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_div';
procedure mpf_ui_div(var Dest: mpf_t; Src1: Cardinal; var Src2: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_ui_div';
procedure mpf_div_ui(var Dest: mpf_t; var Src1: mpf_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_div_ui';
procedure mpf_sqrt(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_sqrt';
procedure mpf_sqrt_ui(var Dest: mpf_t; Src: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_sqrt_ui';
procedure mpf_pow_ui(var Dest: mpf_t; var Src1: mpf_t; Src2: Cardinal); cdecl; external GMP_LIB_FILE name '__gmpf_pow_ui';
procedure mpf_neg(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_neg';
procedure mpf_abs(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_abs';
procedure mpf_mul_2exp(var Dest: mpf_t; var Src1: mpf_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_mul_2exp';
procedure mpf_div_2exp(var Dest: mpf_t; var Src1: mpf_t; Src2: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_div_2exp';

procedure mpf_ceil(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_ceil';
procedure mpf_floor(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_floor';
procedure mpf_trunc(var Dest: mpf_t; var Src: mpf_t); cdecl; external GMP_LIB_FILE name '__gmpf_trunc';
function mpf_integer_p(var Src: mpf_t): Integer; cdecl; external GMP_LIB_FILE name '__gmpf_integer_p';

procedure mpf_urandomb(var ROP: mpf_t; var State: gmp_randstate_t; NBits: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmpf_urandomb';
procedure mpf_rrandomb(var ROP: mpf_t; var State: gmp_randstate_t; MaxSize: mp_size_t; Exp: mp_exp_t); cdecl; external GMP_LIB_FILE name '__gmpf_rrandomb';

procedure gmp_randinit_default(var State: gmp_randstate_t); cdecl; external GMP_LIB_FILE name '__gmp_randinit_default';
procedure gmp_randinit_mt(var State: gmp_randstate_t); cdecl; external GMP_LIB_FILE name '__gmp_randinit_mt';
procedure gmp_randinit_lc_2exp(var State: gmp_randstate_t; var a: mpz_t; c: Cardinal; M2Exp: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmp_randinit_lc_2exp';
procedure gmp_randinit_lc_2exp_size(var State: gmp_randstate_t; size: mp_bitcnt_t); cdecl; external GMP_LIB_FILE name '__gmp_randinit_lc_2exp';
procedure gmp_randinit_set(var Dest: gmp_randstate_t; var Src: gmp_randstate_t); cdecl; external GMP_LIB_FILE name '__gmp_randinit_set';
procedure gmp_randclear(var State: gmp_randstate_t); cdecl; external GMP_LIB_FILE name '__gmp_randclear';
procedure gmp_randseed(var State: gmp_randstate_t; Seed: mpz_t); cdecl; external GMP_LIB_FILE name '__gmp_randseed';
procedure gmp_randseed_ui(var State: gmp_randstate_t; Seed: Cardinal); cdecl; external GMP_LIB_FILE name '__gmp_randseed_ui';
function gmp_urandomb_ui(var State: gmp_randstate_t; n: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmp_urandomb_ui';
function gmp_urandomm_ui(var State: gmp_randstate_t; n: Cardinal): Cardinal; cdecl; external GMP_LIB_FILE name '__gmp_urandomm_ui';

{ Formatted I/O functions }
// for "..." arguments, pointer to mpx_t and PAnsiChar should be used.
// e.g:
//    var i: mpz_t;
//        buf: AnsiString;
//    begin
//       mpz_init_set_ui(i, 12345);
//       SetLength(buf, 100); // allocate memory
//       gmp_printf(PAnsiChar(buf), '%s is an mpz %Zd', PAnsiChar('hear'), @i);
//       mpz_clear(i);
//    end;

// for rational numbers,
procedure gmp_printf(Buf: PAnsiChar; Fmt: PAnsiChar{; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmp_sprintf';
procedure gmp_scanf(Buf: PAnsiChar; Fmt: PAnsiChar{; ...}); cdecl; varargs; external GMP_LIB_FILE name '__gmp_sscanf';

{ Extensions to the GMP library, implemented in this unit }

procedure mpf_exp(var Dest: mpf_t; var Src: mpf_t);
procedure mpf_ln(var Dest: mpf_t; var Src: mpf_t);
procedure mpf_pow(var Dest: mpf_t; var Src1, Src2: mpf_t);
procedure mpf_sin(var Dest: mpf_t; var Src: mpf_t);
procedure mpf_cos(var Dest: mpf_t; var Src: mpf_t);
procedure mpf_arctan(var Dest: mpf_t; var Src: mpf_t);
procedure mpf_pi(var Dest: mpf_t);

implementation

function mpz_odd_p(var Src: mpz_t): Integer;
begin
   if Src.mp_size = 0 then
      Result := 0
   else
      Result := 1 and Src.mp_d^; // Test the lowest bit of the first limb.
end;

function mpz_even_p(var Src: mpz_t): Integer;
begin
   Result := not mpz_odd_p(Src);
end;

function mpq_numref(var Src: mpq_t): pmpz_t;
begin
   Result := @Src.mp_num;
end;

function mpq_denref(var Src: mpq_t): pmpz_t;
begin
   Result := @Src.mp_den;
end;

procedure mpz_set_uint64(var Dest: mpz_t; const Src: UInt64); // by delphi code
type
   _UINT64 = record
      m_lo: UInt32;
      m_hi: UInt32;
   end;
begin
   mpz_set_ui(Dest, _UINT64(Src).m_hi);
   mpz_mul_2exp(Dest, Dest, 32);
   mpz_add_ui(Dest, Dest, _UINT64(Src).m_lo);
end;

procedure mpz_set_int64(var Dest: mpz_t; const Src: Int64); // by delphi code
var
   u64: UInt64;
begin
   u64 := Abs(Src);
   mpz_set_uint64(Dest, u64);
   if Src < 0 then
      mpz_neg(Dest, Dest);
end;

function mpz_sgn(var Src: mpz_t): Integer;
begin
   if Src.mp_size < 0 then
      mpz_sgn := -1
   else if Src.mp_size > 0 then
      mpz_sgn := 1
   else
      mpz_sgn := 0;
end;

function mpq_sgn(var Src: mpq_t): Integer;
begin
   if Src.mp_num.mp_size < 0 then
      mpq_sgn := -1
   else if Src.mp_num.mp_size > 0 then
      mpq_sgn := 1
   else
      mpq_sgn := 0;
end;

function mpf_sgn(var Src: mpf_t): Integer;
begin
   if Src.mp_size < 0 then
      mpf_sgn := -1
   else if Src.mp_size > 0 then
      mpf_sgn := 1
   else
      mpf_sgn := 0;
end;

function GetExp(var x: mpf_t): Integer;
begin
   mpf_get_d_2exp(Result, x);
end;

const
   PREC_PRO = 25; // To keep the precision of intermediate calculation.

procedure mpf_exp(var Dest: mpf_t; var Src: mpf_t);
var
   y, s, c0: mpf_t;
   Precision, n: Cardinal;
   Exp, i: mp_exp_t;
   Negative: Boolean;
begin
   Precision := mpf_get_prec(Dest) + PREC_PRO;
   mpf_init2(y, Precision);
   mpf_set(y, Src);
   mpf_set_ui(Dest, 1);
   Negative := mpf_sgn(y) < 0;
   if Negative then
      mpf_neg(y, y);
   Exp := GetExp(y);
   if Exp > 0 then
      mpf_div_2exp(y, y, Exp);
   mpf_init2(c0, Precision);
   mpf_init2(s, Precision);
   mpf_set_ui(s, 1);
   n := 1;
   repeat
      mpf_mul(s, s, y);
      mpf_div_ui(s, s, n);
      mpf_set(c0, Dest);
      mpf_add(Dest, Dest, s);
      Inc(n)
   until mpf_eq(c0, Dest, Precision) <> 0;
   for i := 1 to Exp do
      mpf_mul(Dest, Dest, Dest);
   if Negative then
      mpf_ui_div(Dest, 1, Dest);
   mpf_clear(s);
   mpf_clear(c0);
   mpf_clear(y);
end;

var
   LnHalf: mpf_t;
   LnHalfInited: Boolean = False;

procedure mpf_ln(var Dest: mpf_t; var Src: mpf_t);
var
   y, s, p, c0, Half: mpf_t;
   n, Precision: Cardinal;
   Exp: mp_exp_t;
begin
   if mpf_sgn(Src) <= 0 then
   begin
      Ln(0); { Generate an error }
      Exit;
   end;
   Precision := mpf_get_prec(Dest) + PREC_PRO;
   mpf_init2(y, Precision);
   mpf_set(y, Src);
   mpf_set_ui(Dest, 0);
   Exp := GetExp(y);
   if Exp <> 0 then
   begin
      if not LnHalfInited or (mpf_get_prec(LnHalf) < Precision) then
      begin
         if LnHalfInited then
            mpf_clear(LnHalf);
         LnHalfInited := True;
         mpf_init2(LnHalf, Precision);
         mpf_init2(Half, Precision);
         mpf_set_d(Half, 0.5);
         mpf_ln(LnHalf, Half);
         mpf_clear(Half)
      end;
      mpf_set(Dest, LnHalf);
      mpf_mul_ui(Dest, Dest, Abs(Exp));
      if Exp > 0 then
      begin
         mpf_neg(Dest, Dest);
         mpf_div_2exp(y, y, Exp)
      end
      else
         mpf_mul_2exp(y, y, -Exp)
   end;
   mpf_ui_sub(y, 1, y);
   mpf_init2(c0, Precision);
   mpf_init2(s, Precision);
   mpf_init2(p, Precision);
   mpf_set_si(p, -1);
   n := 1;
   repeat
      mpf_mul(p, p, y);
      mpf_div_ui(s, p, n);
      mpf_set(c0, Dest);
      mpf_add(Dest, Dest, s);
      Inc(n)
   until mpf_eq(c0, Dest, Precision) <> 0;
   mpf_clear(p);
   mpf_clear(s);
   mpf_clear(c0);
   mpf_clear(y);
end;

procedure mpf_pow(var Dest: mpf_t; var Src1, Src2: mpf_t);
var
   Temp: mpf_t;
begin
   mpf_init2(Temp, mpf_get_prec(Src1) + PREC_PRO);
   mpf_ln(Temp, Src1);
   mpf_mul(Temp, Temp, Src2);
   mpf_exp(Dest, Temp);
   mpf_clear(Temp);
end;

procedure mpf_sin(var Dest: mpf_t; var Src: mpf_t);
var
   Precision, Quadrant, n: Cardinal;
   Sign: Integer;
   a, b, z, xx, c0: mpf_t;
begin
   Precision := mpf_get_prec(Dest) + PREC_PRO;
   mpf_init2(a, Precision);
   mpf_init2(b, Precision);
   mpf_init2(z, Precision);
   mpf_init2(xx, Precision);
   mpf_init2(c0, Precision);
   Sign := mpf_sgn(Src);
   mpf_abs(xx, Src);
   mpf_pi(z);
   mpf_div_2exp(z, z, 1);
   mpf_div(a, xx, z);
   mpf_floor(xx, a);
   if mpf_cmp_ui(xx, 4) >= 0 then
   begin
      mpf_div_2exp(b, xx, 2);
      mpf_floor(b, b);
      mpf_mul_2exp(b, b, 2);
      mpf_sub(b, xx, b)
   end
   else
      mpf_set(b, xx);
   Quadrant := mpf_get_ui(b);
   mpf_sub(b, a, xx);
   mpf_mul(xx, z, b);
   if Quadrant > 1 then
      Sign := -Sign;
   if Odd(Quadrant) then
      mpf_sub(xx, z, xx);
   mpf_mul(z, xx, xx);
   mpf_neg(z, z);
   n := 1;
   mpf_set_ui(b, 1);
   mpf_set_ui(Dest, 1);
   repeat
      Inc(n);
      mpf_div_ui(b, b, n);
      Inc(n);
      mpf_div_ui(b, b, n);
      mpf_mul(b, b, z);
      mpf_set(c0, Dest);
      mpf_add(Dest, Dest, b)
   until mpf_eq(c0, Dest, Precision) <> 0;
   mpf_mul(Dest, Dest, xx);
   if Sign < 0 then
      mpf_neg(Dest, Dest);
   mpf_clear(a);
   mpf_clear(b);
   mpf_clear(z);
   mpf_clear(xx);
   mpf_clear(c0);
end;

procedure mpf_cos(var Dest: mpf_t; var Src: mpf_t);
var
   Temp: mpf_t;
begin
   mpf_init2(Temp, mpf_get_prec(Dest) + PREC_PRO);
   mpf_pi(Temp);
   mpf_div_2exp(Temp, Temp, 1);
   mpf_sub(Temp, Temp, Src);
   mpf_sin(Dest, Temp);
   mpf_clear(Temp);
end;

var
   SqRtTwo: mpf_t;
   SqRtTwoInited: Boolean = False;

procedure mpf_arctan(var Dest: mpf_t; var Src: mpf_t);
var
   Precision, n: Cardinal;
   xx, mx2, a, b: mpf_t;
begin
   Precision := mpf_get_prec(Dest) + PREC_PRO;
   mpf_init2(xx, Precision);
   mpf_init2(mx2, Precision);
   mpf_init2(a, Precision);
   mpf_init2(b, Precision);
   mpf_abs(xx, Src);
   if not SqRtTwoInited or (mpf_get_prec(SqRtTwo) < Precision) then
   begin
      if SqRtTwoInited then
         mpf_clear(SqRtTwo);
      SqRtTwoInited := True;
      mpf_init2(SqRtTwo, Precision);
      mpf_sqrt_ui(SqRtTwo, 2)
   end;
   mpf_add_ui(a, SqRtTwo, 1);
   if mpf_cmp(xx, a) > 0 then
   begin
      mpf_pi(Dest);
      mpf_div_2exp(Dest, Dest, 1);
      mpf_ui_div(xx, 1, xx);
      mpf_neg(xx, xx)
   end
   else
   begin
      mpf_sub_ui(b, SqRtTwo, 1);
      if mpf_cmp(xx, b) > 0 then
      begin
         mpf_pi(Dest);
         mpf_div_2exp(Dest, Dest, 2);
         mpf_sub_ui(a, xx, 1);
         mpf_add_ui(b, xx, 1);
         mpf_div(xx, a, b)
      end
      else
         mpf_set_ui(Dest, 0)
   end;
   mpf_mul(mx2, xx, xx);
   mpf_neg(mx2, mx2);
   mpf_add(Dest, Dest, xx);
   n := 1;
   repeat
      mpf_mul(xx, xx, mx2);
      mpf_div_ui(a, xx, 2 * n + 1);
      mpf_set(b, Dest);
      mpf_add(Dest, Dest, a);
      Inc(n)
   until mpf_eq(b, Dest, Precision) <> 0;
   if mpf_sgn(Src) < 0 then
      mpf_neg(Dest, Dest);
   mpf_clear(xx);
   mpf_clear(mx2);
   mpf_clear(a);
   mpf_clear(b);
end;

var
   _Pi: mpf_t;
   PiInited: Boolean = False;

procedure mpf_pi(var Dest: mpf_t);
{ 4 arctan 1/5 - arctan 1/239 = pi/4 }
var
   b: mpf_t;
   Precision: Cardinal;
begin
   Precision := mpf_get_prec(Dest) + PREC_PRO;
   if not PiInited or (mpf_get_prec(_Pi) < Precision) then
   begin
      if PiInited then
         mpf_clear(_Pi);
      PiInited := True;
      mpf_init2(_Pi, Precision);
      mpf_set_ui(_Pi, 1);
      mpf_div_ui(_Pi, _Pi, 5);
      mpf_arctan(_Pi, _Pi);
      mpf_mul_ui(_Pi, _Pi, 4);
      mpf_init2(b, Precision);
      mpf_set_ui(b, 1);
      mpf_div_ui(b, b, 239);
      mpf_arctan(b, b);
      mpf_sub(_Pi, _Pi, b);
      mpf_mul_ui(_Pi, _Pi, 4);
      mpf_clear(b)
   end;
   mpf_set(Dest, _Pi);
end;

initialization
finalization

   if LnHalfInited then
      mpf_clear(LnHalf);

   if SqRtTwoInited then
      mpf_clear(SqRtTwo);

   if PiInited then
      mpf_clear(_Pi);

end.
