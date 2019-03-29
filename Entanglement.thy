(* Author: Anthony Bordg, University of Cambridge, apdb3@cam.ac.uk *)

theory Entanglement
imports
  Main
  Jordan_Normal_Form.Matrix
  Quantum
  Tensor
begin


section\<open>Quantum Entanglement\<close>

subsection\<open>The Product States and Entangled States of a 2-qubits System\<close>

definition prod_state ::"complex Matrix.vec \<Rightarrow> bool" where
"prod_state u \<equiv> if u \<in> state_qbit 2 then \<exists>v \<in> state_qbit 1.\<exists> w \<in> state_qbit 1. u = v \<otimes> w else undefined"

definition entangled2 ::"complex Matrix.vec \<Rightarrow> bool" where
"entangled2 u \<equiv> \<not> prod_state u"

text\<open>The Bell states are entangled states\<close>

lemma bell_00_is_entangled2:
  shows "entangled2 bell_00" 
proof-
  have "\<forall>v \<in> state_qbit 1. \<forall> w \<in> state_qbit 1. |\<beta>\<^sub>0\<^sub>0\<rangle> \<noteq> v \<otimes> w"
  proof-
    have "\<exists>v \<in> state_qbit 1. \<exists> w \<in> state_qbit 1. |\<beta>\<^sub>0\<^sub>0\<rangle> = v \<otimes> w \<Longrightarrow> False"
    proof-
      assume asm:"\<exists>v \<in> state_qbit 1. \<exists> w \<in> state_qbit 1. |\<beta>\<^sub>0\<^sub>0\<rangle> = v \<otimes> w"
      obtain v and w where "v \<in> state_qbit 1" and "w \<in> state_qbit 1" and "|\<beta>\<^sub>0\<^sub>0\<rangle> = v \<otimes> w"
        using asm
        by blast
      hence "|\<beta>\<^sub>0\<^sub>0\<rangle> $ 0 = (v \<otimes> w) $ 0"
        by simp
      hence "(v \<otimes> w) $ 0 = 1 / complex_of_real (sqrt 2)"
        by(simp add: bell_00_def)
      have f1:"mult.vec_vec_Tensor ( * ) \<equiv> rec_list (\<lambda>ys. []) (\<lambda>x xs xsa ys. mult.times ( * ) x ys @ xsa ys)"
      proof-
        have f0:"Matrix_Tensor.mult (1::complex) ( * )" sorry
        then show "mult.vec_vec_Tensor ( * ) \<equiv> rec_list (\<lambda>ys. []) (\<lambda>x xs xsa ys. mult.times ( * ) x ys @ xsa ys)"
          using mult.vec_vec_Tensor_def[of "(1::complex)" "( * )"]
          sorry
      qed
      have "(v \<otimes> w) $ 0 = v $ 0 * w $ 0"
        apply(simp add: tensor_vec_def f1 mult.times.simps)
        sorry
      show False
        using state_qbit_def
        sorry
    qed
    then show "\<forall>v \<in> state_qbit 1. \<forall> w \<in> state_qbit 1. |\<beta>\<^sub>0\<^sub>0\<rangle> \<noteq> v \<otimes> w"
      by blast
  qed
  then show ?thesis 
    by(simp add: entangled2_def prod_state_def bell_00_is_state)
qed

lemma bell_01_is_entangled2:
  shows "entangled2 bell_01" sorry

lemma bell_10_is_entangled2:
  shows "entangled2 bell_10" sorry

lemma bell_11_is_entangled2:
  shows "entangled2 bell_11" sorry



end