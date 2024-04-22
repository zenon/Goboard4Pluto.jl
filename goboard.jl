### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ d45c5cf9-4242-4b49-bb8d-d543e374a10f
using PlutoUI

# ╔═╡ 86294e46-4a3d-4f3b-a528-2561395fb1ab
md"# Go in Pluto? 围棋"

# ╔═╡ 63d03489-3e1e-4c8f-bc15-bd316e7e2a79
md"## Notes, skip in presentation"

# ╔═╡ 5e8d6617-2a16-42c7-aa9d-cc795458fd6a
md"""__Questions & Tasks__
- Should I use https://evizero.github.io/SmartGameFormat.jl/latest ?
- board size in vis with default?
"""

# ╔═╡ b53f1917-3dd0-40ad-b586-445ac22aa919
md"""
### Notes about the visualisation

[Github project](https://github.com/deebloo/go-board/) by Danny Blue

attributes: coords debug readonly disablelastmarker

Nice wood background:
style="background-image: 
      url(https://cdn.jsdelivr.net/npm/go-board@2.3.2/assets/textures/kaya.jpg);"

For some reason, this doesn't completely work nice.
"""

# ╔═╡ 4e5ff2c7-b598-4e36-9d73-a3342b474145
md"## Preparation, and declaring of some functions"

# ╔═╡ 497d68ea-bb27-43e6-98fb-f660bdd8cbf7
function num2charGO(n)
	code = [collect('A' : 'H') ; collect('J' : 'Z')] # works up to 25
	code[n]
end

# ╔═╡ 603c3e07-c313-4b6b-8045-61c449f2d6ef
begin
	function showGoBoard(n, moves)
    	
	    s = "<go-board coords readonly rows=$n cols=$n>"
    	for m in moves
			if m[1] == :b
				s *= 
	"""<go-stone color="black" slot="$(num2charGO(m[2]))$(m[3])"></go-stone>"""
			elseif m[1] == :w
				s *= 
	"""<go-stone color="white" slot="$(num2charGO(m[2]))$(m[3])"></go-stone>"""
			else
				# pass
			end
    	end
		s *= "</go-board>"
		HTML{String}(s)
	end
	html"""
<script src="https://cdn.jsdelivr.net/npm/go-board@latest/bundle/go-board.min.js">
</script>
<b>loaded</b>
	"""
end

# ╔═╡ 021c885d-ff2e-427f-bd73-fe4a8fb3f1e9
md"## Test the visualisation"

# ╔═╡ f5302e86-06b5-4265-8f12-9b2979e670c0
game1 = [(:b,3,5), (:w,9,16), (:b,2,7), (:w,6,6), (:b,10,16), (:w,8,16)]

# ╔═╡ 45c1473b-b76b-48b9-b440-51d4453791eb
@bind step Slider(0:length(game1); default=length(game1), show_value=true)

# ╔═╡ be34c93b-a655-40ab-9df0-28ca98bbdf66
showGoBoard(19, game1[1:step])

# ╔═╡ 1bf2f772-5bdb-4439-b48e-8d8d709b1bd5
begin
	# from https://homepages.cwi.nl/~aeb/go/games/games/
	Shusaku_Ear_Reddening_Game = """
	(;
PB[Yasuda Shusaku]
BR[4d]
PW[Inoue Gennan Inseki]
WR[8d]
RE[B+2]
JD[Koka 3-7-21,24,25]
DT[1846-09-11,14,15]

;B[qd];W[dc];B[pq];W[oc];B[cp];W[cf];B[ep];W[qo];B[pe];W[np]
;B[po];W[pp];B[op];W[qp];B[oq];W[oo];B[pn];W[qq];B[nq];W[on]
;B[pm];W[om];B[pl];W[mp];B[mq];W[ol];B[pk];W[lq];B[lr];W[kr]
;B[lp];W[kq];B[qr];W[rr];B[rs];W[mr];B[nr];W[pr];B[ps];W[qs]
;B[no];W[mo];B[qr];W[rm];B[rl];W[qs];B[lo];W[mn];B[qr];W[qm]
;B[or];W[ql];B[qj];W[rj];B[ri];W[rk];B[ln];W[mm];B[qi];W[rq]
;B[jn];W[ls];B[ns];W[gq];B[go];W[ck];B[kc];W[ic];B[pc];W[nj]
;B[ke];W[og];B[oh];W[pb];B[qb];W[ng];B[mi];W[mj];B[nd];W[ph]
;B[qg];W[pg];B[hq];W[hr];B[ir];W[iq];B[hp];W[jr];B[fc];W[lc]
;B[ld];W[mc];B[lb];W[mb];B[md];W[qf];B[pf];W[qh];B[rg];W[rh]
;B[sh];W[rf];B[sg];W[pj];B[pi];W[oi];B[oj];W[ni];B[qk];W[ok]
;B[qe];W[kb];B[jb];W[ka];B[jc];W[ob];B[ja];W[la];B[db];W[cc]
;B[fe];W[cn];B[gr];W[is];B[fq];W[io];B[ji];W[eb];B[fb];W[eg]
;B[dj];W[dk];B[ej];W[cj];B[dh];W[ij];B[hm];W[gj];B[eh];W[fl]
;B[fg];W[er];B[dm];W[fn];B[dn];W[gn];B[jj];W[jk];B[kk];W[ii]
;B[ik];W[jl];B[kl];W[il];B[jh];W[co];B[do];W[ih];B[hn];W[hl]
;B[bl];W[dg];B[gh];W[ch];B[ig];W[ec];B[cr];W[fd];B[gd];W[ed]
;B[gc];W[bk];B[cm];W[gs];B[gp];W[li];B[kg];W[in];B[lj];W[lg]
;B[gm];W[jf];B[jg];W[im];B[fm];W[kf];B[lf];W[mf];B[le];W[gf]
;B[hf];W[ff];B[gg];W[lk];B[kj];W[km];B[lm];W[ll];B[jm];W[ge]
;B[he];W[ef];B[ea];W[cb];B[fr];W[fs];B[dr];W[qa];B[ra];W[pa]
;B[rb];W[da];B[gi];W[fj];B[fi];W[fa];B[ga];W[gl];B[ek];W[em]
;B[ho];W[el];B[en];W[jo];B[kn];W[ci];B[lh];W[mh];B[mg];W[di]
;B[ei];W[lg];B[qn];W[rn];B[re];W[sl];B[mg];W[bm];B[am];W[lg]
;B[eq];W[es];B[mg];W[ha];B[gb];W[lg];B[ds];W[hs];B[mg];W[sj]
;B[si];W[lg];B[sr];W[sq];B[mg];W[hd];B[hb];W[lg];B[ro];W[so]
;B[mg];W[ss];B[qs];W[lg];B[sn];W[rp];B[mg];W[cl];B[bn];W[lg]
;B[ml];W[mk];B[mg];W[pj];B[sf];W[lg];B[nn];W[nl];B[mg];W[ib]
;B[ia];W[lg];B[nc];W[nb];B[mg];W[jd];B[kd];W[lg];B[ma];W[na]
;B[mg];W[qc];B[rc];W[lg];B[js];W[ks];B[mg];W[hc];B[id];W[lg]
;B[fk];W[hj];B[mg];W[hh];B[hg];W[lg];B[gk];W[hk];B[mg];W[ak]
;B[lg];W[al];B[bm];W[nf];B[od];W[ki];B[ms];W[kp];B[ip];W[jp]
;B[lr];W[oj];B[mr];W[ea];B[sr])
	"""
	Shusaku_Last_Castle_Game = """
	(;
EV[Castle Game]
RO[19/19]
PB[Hayashi Yubi]
BR[6d]
PW[Honinbo Shusaku]
WR[7d]
RE[W+R]
JD[Bunkyu 1-11-17,18]
DT[1861-12-18,19]
PC[Edo Castle]

;B[qd];W[dc];B[od];W[qp];B[cp];W[eq];B[hq];W[nq];B[ep];W[dq]
;B[dp];W[gq];B[gp];W[fq];B[hp];W[cq];B[bp];W[bq];B[ce];W[cj]
;B[cl];W[cg];B[qj];W[qm];B[gc];W[ed];B[jc];W[pi];B[pj];W[oi]
;B[rh];W[fe];B[nk];W[mi];B[bc];W[bb];B[lq];W[no];B[dh];W[ch]
;B[dj];W[ck];B[dk];W[dg];B[di];W[bl];B[cm];W[kd];B[kc];W[md]
;B[lj];W[li];B[kj];W[lc];B[jd];W[ke];B[je];W[kf];B[pn];W[qn]
;B[pq];W[pp];B[lo];W[lr];B[oq];W[mq];B[op];W[oo];B[qq];W[rp]
;B[rr];W[mo];B[nr];W[mr];B[ns];W[fb];B[ig];W[jh];B[ci];W[bi]
;B[bh];W[bg];B[jg];W[kg];B[bj];W[ah];B[bk];W[fg];B[gh];W[ih]
;B[gg];W[he];B[gf];W[ge];B[ie];W[fh];B[nc];W[mb];B[gi];W[pf]
;B[of];W[pg];B[pe];W[rg];B[re];W[qh];B[ij];W[ln];B[pm];W[pl]
;B[ol];W[ql];B[oj];W[mj];B[nm];W[po];B[ri];W[ne];B[oe];W[mk]
;B[lm];W[kn];B[km];W[jn];B[ki];W[kh];B[ng];W[og];B[nf];W[nh]
;B[mg];W[mh];B[nb];W[na];B[aq];W[ar];B[ap];W[hn];B[gn];W[gm]
;B[ml];W[jm])
	"""
	Ishida_Yoshio_vs_Otake_Hideo = """
	(;
EV[1st Meijin Title]
RO[1]
PB[Otake Hideo]
BR[Meijin]
PW[Ishida Yoshio]
WR[9p]
TM[9h]
KM[5]
RE[B+R]
DT[1976-09-16,17]

;B[pd];W[cq];B[pq];W[cc];B[qk];W[nc];B[pf];W[jd];B[fp];W[dn]
;B[ip];W[ed];B[po];W[di];B[ji];W[ko];B[kq];W[qp];B[qo];W[io]
;B[hp];W[ll];B[jl];W[ln];B[jn];W[jo];B[gm];W[lj];B[dl];W[mg]
;B[mm];W[lm];B[if];W[he];B[ff];W[ge];B[ee];W[dd];B[dg];W[gg]
;B[ei];W[hg];B[dj];W[cm];B[me];W[oj];B[ld];W[qc];B[pc];W[pb]
;B[ob];W[qb];B[oc];W[re];B[rf];W[qe];B[qf];W[pe];B[oe];W[qd]
;B[jc];W[ic];B[kc];W[ib];B[nh];W[ni];B[mh];W[oh];B[og];W[pl]
;B[no];W[mo];B[mp];W[lp];B[mn];W[lo];B[lq];W[np];B[mq];W[lh]
;B[ng];W[oo];B[nn];W[pp];B[on];W[op];B[rp];W[rq];B[ro];W[oq]
;B[rr];W[qq];B[sq];W[nr];B[ql];W[mr];B[dq];W[cp];B[cr];W[br]
;B[kk];W[ml];B[mi];W[mj];B[im];W[kj];B[jj];W[kh];B[ig];W[jg]
;B[id];W[ie];B[jf];W[pk];B[pm];W[jh];B[ih];W[kf];B[je];W[lf]
;B[ol];W[ok];B[nl];W[nk];B[pi];W[oi];B[lr];W[pr];B[hd];W[gc]
;B[mf];W[ph];B[qi];W[lg];B[dr];W[bj];B[ci];W[bi];B[dp];W[do]
;B[bh];W[ck];B[dk];W[gi];B[bs];W[ar];B[cl];W[bl];B[se];W[sd]
;B[sf];W[sb];B[jb];W[hc];B[gj];W[hi];B[hj];W[qh];B[rh];W[gd]
;B[cj];W[bk];B[bf];W[kd];B[ke];W[id];B[ii];W[bd];B[ja];W[fo]
;B[ep];W[go];B[gp];W[qj];B[rj];W[pj];B[ri]
C[Time used: B: 7h59m, W: 8h59m]
)
	"""
	md"Three games preloaded"
end

# ╔═╡ e0967b7d-042c-45a3-a10f-9ffd2741e7a5
md"## Test the visualisation 2: Real games"

# ╔═╡ b6677591-96d9-4b70-bfe9-bb796efd58fb
let
	files = [
		Shusaku_Ear_Reddening_Game => "Shusaku, the ear reddening game", 
		Shusaku_Last_Castle_Game => "Shusaku, the last castle game", 
		Ishida_Yoshio_vs_Otake_Hideo => "White Ishida Yoshio, Black Otake Hideo, Meijin Tournament 1976" ]
	@bind gameFile Select(files)
end

# ╔═╡ bf450084-e1a3-4121-925f-7e59f5555efa
game2 = let
	# doesn't handle passes, trees, ...
	s = gameFile #read("c:\\daten\\"*gameFile, String)
	sgfMoves = filter(x -> startswith(x, "B[")||startswith(x, "W["), split(s, ";"))
	code = [collect('a' : 'h') ; collect('j' : 't')]
	decode(c) = c - 'a' + 1
	# test: map(decode, code)

	function decodeSGFMove(m)
		color = m[1] == 'B' ? :b : :w
		x = decode(m[3])
		y = 20-decode(m[4]) # sgf counts top to bottom
		(color, x, y)
	end
	
	map(decodeSGFMove, sgfMoves)

end;

# ╔═╡ 0f9f340a-3e3c-45e0-baa4-1b646fd4bbf3
@bind stepER Slider(0:length(game2); default=length(game2), show_value=true)

# ╔═╡ 173ef15b-b614-4926-b5d8-a291da0c4041
showGoBoard(19, game2[1:stepER])

# ╔═╡ 2beb7424-0b90-4f9a-92cf-9f39d03b63e3
if stepER == 0
	md"Start of the game. The board is empty."
else
	c, x, y = game2[stepER]
	C = c == :b ? "Black" : "White"
	X = num2charGO(x)
	s = "Move number " * string(stepER) * " of $(length(game2)): __$C at " 
	s = s * string(X) * string(y) * "__"
	Markdown.parse(s)
end

# ╔═╡ b2008c08-2d32-4551-9d9b-7b1aad77e3a9
md"## Modelling game and board"

# ╔═╡ 9bed1222-ac06-4e3b-ac2f-e28a5dc0b53b
md"""
__Rules__
1. Go is a game between two players. We call them Black and White, and it 
   starts on an empty board. Black has the first turn.
1. A game is a sequence of turns, the players (black and white) alternate. 
1. A turn is either a pass or the placing of a stone on an empty intersection.
1. A pass simply changes nothing, but now it's the other players turn.
1. _Visually_ Define: freedom of a stone; string (aka chain), freedom of a string [mention the word "group" as a less formal generalization of string.]
1. Placing a stone can take the last freedom of stones or strings, they are now dead. In that case remove the dead stones of the other player. Otherwise, if it's your own stones that are dead, remove those. [Note that the "otherwise" branch is only possible when no stones of the other player needed removal. This is called suicide and some rules, e.g. the japanese ones, prohibit it.]
1. The game ends when both players pass immediately one after another.
1. The player with most stones on the board wins.
1. Ko rule, to prevent loops: If a single stone A has just been killed by the 
   single stone B, it 
   is not allowed to kill B back immediately by playing at the position 
   of the former stone A.
1. If the game runs into any other kind of infinite loop, it's a draw. Such lops are 
   excitingly rare. Document the game and have a party.
"""

# ╔═╡ 30b14cff-dd19-4eeb-ac6f-8784ab2061e8
html"<go-board coords rows=9 cols=9 ></go-board>"

# ╔═╡ 86622f91-f4ea-42a9-8a8a-d73fd9ef977c
md"""
Notes about above rules: 
- The only non standard part (remember that there are severals rule sets) is the win criterion. It will lead to playing into own territory but shouldn't much change the result compared to chinese counting. Dame will be filled, of course. The games will have a boring part after what is usually the end game with any standard rules. After some games of this kind have been played, it may be understandable why standard rules count differently: to get rid of this boring part.
- I wanted to be as simple as possible. To be a bit nearer to area scoring, we should count eyes too. The player will learn to keep his eyes open, but in the rules above, she is "punished" for it.
- This is a rule set to explain the rules. Komi, or who plays first, or any rules
  to enable tournaments will come much later.
"""

# ╔═╡ 8b546042-64d7-4ef1-af03-cac9c920c6e9
md"## Helper functions"

# ╔═╡ 5232ae08-8aea-45b2-a830-d58880c56b2c
struct Board
	n :: Int8
	board :: Matrix{Int8}
	lastKilled :: Vector{CartesianIndex} # for Ko
	Board(n) = new(n, zeros(Int8, n, n), [])
end

# ╔═╡ a414fce6-582c-4372-93af-a06affc8f73c
isEmpty(board, i, j) = board.board[i,j] == 0

# ╔═╡ 13e8e87f-5e15-42c1-81b1-f551af28e041
isEmpty(board, idx) = isEmpty(board, idx[1], idx[2])

# ╔═╡ 218a4ed8-2e6c-4f18-a64b-2d19d54c0da9
emptyPlaces(board) = findall(iszero, board.board)

# ╔═╡ a699bf33-8448-4253-9402-b4e100ddf215
md"Is it possible to memoize the neighbours function?"

# ╔═╡ 9efc2fd5-5434-4a4d-b16f-d9ad50e65167
# name might be confusing. finds neighbouring positions, not stones
function neighbours(n, idx)
	nb = []
	x = idx[1]
	y = idx[2]
	if x > 1
		push!(nb, CartesianIndex(x-1, y))
	end
	if x < n
		push!(nb, CartesianIndex(x+1, y))
	end
	if y > 1
		push!(nb, CartesianIndex(x, y-1))
	end
	if y < n
		push!(nb, CartesianIndex(x, y+1))
	end
	nb
end

# ╔═╡ 5d96797a-f2c8-4dd1-86ff-fa28eeea6575
# doesn't check whether it kills
function isSingleStoneSuicide(board, idx, player)
	partnerCode = player == :b ? 2 : 1
	all([board.board[i] == partnerCode for i in neighbours(board.n, idx)])
end

# ╔═╡ 122504c4-c063-4727-8b5f-970eb21efd3c
# can also find an connected empty space
# group?? string!
function groupOf(board, idx)
	group = [idx]
	new = [idx]
	code = board.board[idx]
	count = 0
	while !isempty(new) && count < 100 #TODO
		ns = filter(i -> board.board[i] == code, 
			unique(vcat(map(id -> neighbours(board.n, id), new)...)))
		new = setdiff(ns, group)
		group = union(group, new)
		count += 1
	end
	if count > 99
		println("Oh. 100")
	end
	sort(group)
end

# ╔═╡ 6c44a484-0304-4052-aab1-01cfc3f9fc2a
function isOwnSinglePointEye(board, idx, player)
	# empty has been tested before
	ownCode = player == :b ? 1 : 2
	neighbourPositions = neighbours(board.n, idx)
	# can be a color or space
	aNeighbourGroup = groupOf(board, neighbourPositions[1])
	# must be my color AND of a single string
	all([board.board[i] == ownCode && i ∈ aNeighbourGroup
		for i in neighbourPositions])
end

# ╔═╡ 43f46fb9-4772-4166-92bd-1dc97ae5ed94
function isBlockedByKo(game, board, idx, player)
	group = groupOf(board, idx)
	if (board.board[group[1]] == (player == :b ? :w : :b) 
	    	&& length(board.lastKilled) == 1 
			&& board.lastKilled[1] == idx 
			&& length(group) == 1)
		# this is either ko or single stone suicide, right?
		# (the latter is checked before)
		println("blocking ko at move $(length(game)+1) at $idx")
		true
	else
		false
	end
end

# ╔═╡ 946e8640-eb34-4998-9dd9-c8170a6212f2
function neighboursOfGroup(board, group)
	code = board.board[group[1]]
	filter(i -> board.board[i] != code, 
			unique(vcat(map(id -> neighbours(board.n, id), group)...)))
end

# ╔═╡ 8232b798-732a-42c0-9d9b-99c62e5c0895
function freedomCount(board, group)
	neighbours = neighboursOfGroup(board, group)
	z = zero(Int8)
	emptyPositions = filter(n -> n==z, map(idx -> board.board[idx], neighbours))
	length(emptyPositions)
end

# ╔═╡ 845a1605-be2d-4ac2-b287-338695aae2b0
function removeGroup(board, group)
	for idx in group
		board.board[idx] = 0
	end
end

# ╔═╡ b91ff490-21d1-4f39-bf57-4e11e7c62eec
function removePartnersStones(board, idx, player)
	partnerCode = player == :b ? 2 : 1
	neighbourPositions = neighbours(board.n, idx)
	neighbourPartnerStones = filter(i -> board.board[i] == partnerCode,
		neighbourPositions)
	neighbourGroups = unique(map(ii -> groupOf(board, ii), neighbourPartnerStones))
	for group in neighbourGroups
		if freedomCount(board, group) == 0
			removeGroup(board, group)
			for i in group
				push!(board.lastKilled, i)
			end
		end
	end
end

# ╔═╡ 4c50090b-e5ed-4425-a5d1-964e450540e5
function isSuicide(board, idx, player)
	n = board.n
	b = Board(n)
	for i in 1:n
		for j in 1:n
			b.board[i,j] = board.board[i,j]
		end
	end
	b.board[idx] = player == :b ? 1 : 2
	removePartnersStones(b, idx, player)
	group = groupOf(b, idx)
	freedomCount(b, group) == 0
end

# ╔═╡ dad45f0e-08d5-4b91-b276-048611d9b0e0
isAllowed(game, board, idx, player) = all([
	isEmpty(board, idx)
	#!isSingleStoneSuicide(board, idx, player) # still wrong
	!isOwnSinglePointEye(board, idx, player)
	!isSuicide(board, idx, player)
	!isBlockedByKo(game, board, idx, player)
])

# ╔═╡ b81c4d5a-06ff-4fb4-a159-b0b0ad5b4429
function removeOwnStones(board, idx, player)
	group =  groupOf(board, idx)
	if freedomCount(board, group) == 0
		removeGroup(board, group)
	end
end

# ╔═╡ ea98a1a6-77e3-41b1-a22b-06b1d518b082
md"## Now towards the [most ignorant bot](https://senseis.xmp.net/?MostIgnorantBotImaginable)"

# ╔═╡ f6423aa8-72d9-4a3c-977b-0e7decef5af6
#game stops too early, already if one player doesn't have a allowed position
function dumbPlay(n)
	b = Board(Int8(n))
	g = []
	possibilities = emptyPlaces(b)
	player = :b
	count = 1
	passes = []
	while count < 10000 && sort(passes) != [:b, :w]
		done = false
		passes = filter(p -> p != player, passes)
		while !done
			i = rand(possibilities)
			if isAllowed(g, b, i, player)
				push!(g, (player, i[1], i[2]))
				empty!(b.lastKilled)
				b.board[i] = player == :b ? 1 : 2
				removePartnersStones(b, i, player)
				removeOwnStones(b, i, player)
				done = true
			else
				possibilities = filter(idx -> idx != i, possibilities)
			end
			if isempty(possibilities)
				done = true
			end
		end
		if isempty(possibilities)
			println("$player passes.")
			push!(passes, player)
		end
		player = player == :b ? :w : :b
		possibilities = emptyPlaces(b)
		if length(passes) > 2
			println("to many players passed")
		end
		count += 1
	end
	println(count)
	(g, b)
end

# ╔═╡ b396f06a-f50f-48f0-a5db-6ce584f3f354
md"""## let's test the helpers"""

# ╔═╡ 5ff73eaa-f7fb-42c3-8346-6f1b36f4bcd4
b9 = Board(9)

# ╔═╡ f14e05b5-1f4b-45ee-9286-1ceff7e005f3
isEmpty(b9, 3, 3)

# ╔═╡ a7491586-d529-4ce3-b8a2-276c5dfd6b39
i = rand(emptyPlaces(b9))

# ╔═╡ cb692706-56de-4d92-8853-e6d30ea9b918
isAllowed([], b9, i, :b)

# ╔═╡ 149b5bc6-15dd-4a67-a047-95e2fe4e5110
neighbours(9, CartesianIndex(9,9))

# ╔═╡ 5b933fe0-e7d9-4031-8176-d3e3f2a242e4
isSingleStoneSuicide(b9, i, :b)

# ╔═╡ bd275886-d649-4bda-835f-49ba73e07e0a
@time game3 = dumbPlay(19)

# ╔═╡ cfc72b42-d79b-4802-8e38-7eaed723ac8d
freedomCount(game3[2], groupOf(game3[2],i))

# ╔═╡ 28bf3161-80a8-4e9b-b8c3-6b5d41c30b0f
map(idx -> idx, neighboursOfGroup(game3[2], groupOf(game3[2],i)))

# ╔═╡ deb4fe13-f0ff-4696-a22a-711db6c503a0
map(idx -> game3[2].board[idx], neighboursOfGroup(game3[2], groupOf(game3[2],i)))

# ╔═╡ e705f186-aa45-4e0d-ba3d-1a972da3b6c3
removePartnersStones(game3[2], i, :b)

# ╔═╡ c629c3f7-6207-4f9e-a60c-97c53b91953c
game3[2].board

# ╔═╡ 856f4dfb-668f-4361-a7b1-c33fca5549c6
@bind step3 Slider(0:length(game3[1]); default=0, show_value=true)

# ╔═╡ 90ef2c71-037a-409f-ae2f-36d2e52fb338
showGoBoard(game3[2].n, game3[1][1:step3])

# ╔═╡ e4656a24-afc2-4543-acec-ee6f602aaa17
let
	if step3 == 0
		md"Start of the game. The board is empty."
	else
		c, x, y = game3[1][step3]
		C = c == :b ? "Black" : "White"
		X = num2charGO(x)
		s = "Move number " * string(step3) * " of $(length(game3[1])): __$C at " 
		s = s * string(X) * string(y) * "__"
		Markdown.parse(s)
	end
end

# ╔═╡ 51b11ffd-74cd-4e15-ac82-43a0b8eea785
reverse(game3[2].board, dims=2)'

# ╔═╡ a0bcc8bc-1045-41aa-9b51-374ff3206f52
isEmpty(game3[2], CartesianIndex(3,6))

# ╔═╡ fb0e9c58-17a5-48f4-95d9-eccd161fcfe0
isAllowed(game3[1], game3[2], CartesianIndex(3,6), :w)

# ╔═╡ 2c0698cf-76ed-475b-b4ff-472c1cea0f0c
md"""
Notes from the [RandomPlay](https://senseis.xmp.net/?RandomPlay) article:
If suicide is allowed, and we count prisoners, I can even loose against a bot that always passes.

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.58"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.1"
manifest_format = "2.0"
project_hash = "acf8a7d70217bc877a8d448fd5475fd91c6dd480"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0f748c81756f2e5e6854298f11ad8b2dfae6911a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═86294e46-4a3d-4f3b-a528-2561395fb1ab
# ╠═63d03489-3e1e-4c8f-bc15-bd316e7e2a79
# ╠═5e8d6617-2a16-42c7-aa9d-cc795458fd6a
# ╠═b53f1917-3dd0-40ad-b586-445ac22aa919
# ╠═4e5ff2c7-b598-4e36-9d73-a3342b474145
# ╠═d45c5cf9-4242-4b49-bb8d-d543e374a10f
# ╠═497d68ea-bb27-43e6-98fb-f660bdd8cbf7
# ╠═603c3e07-c313-4b6b-8045-61c449f2d6ef
# ╠═021c885d-ff2e-427f-bd73-fe4a8fb3f1e9
# ╠═f5302e86-06b5-4265-8f12-9b2979e670c0
# ╠═45c1473b-b76b-48b9-b440-51d4453791eb
# ╠═be34c93b-a655-40ab-9df0-28ca98bbdf66
# ╠═1bf2f772-5bdb-4439-b48e-8d8d709b1bd5
# ╟─bf450084-e1a3-4121-925f-7e59f5555efa
# ╟─e0967b7d-042c-45a3-a10f-9ffd2741e7a5
# ╠═b6677591-96d9-4b70-bfe9-bb796efd58fb
# ╠═0f9f340a-3e3c-45e0-baa4-1b646fd4bbf3
# ╠═173ef15b-b614-4926-b5d8-a291da0c4041
# ╟─2beb7424-0b90-4f9a-92cf-9f39d03b63e3
# ╟─b2008c08-2d32-4551-9d9b-7b1aad77e3a9
# ╟─9bed1222-ac06-4e3b-ac2f-e28a5dc0b53b
# ╠═30b14cff-dd19-4eeb-ac6f-8784ab2061e8
# ╠═86622f91-f4ea-42a9-8a8a-d73fd9ef977c
# ╠═8b546042-64d7-4ef1-af03-cac9c920c6e9
# ╠═5232ae08-8aea-45b2-a830-d58880c56b2c
# ╠═a414fce6-582c-4372-93af-a06affc8f73c
# ╠═13e8e87f-5e15-42c1-81b1-f551af28e041
# ╠═218a4ed8-2e6c-4f18-a64b-2d19d54c0da9
# ╠═a699bf33-8448-4253-9402-b4e100ddf215
# ╠═9efc2fd5-5434-4a4d-b16f-d9ad50e65167
# ╠═5d96797a-f2c8-4dd1-86ff-fa28eeea6575
# ╠═6c44a484-0304-4052-aab1-01cfc3f9fc2a
# ╠═4c50090b-e5ed-4425-a5d1-964e450540e5
# ╠═43f46fb9-4772-4166-92bd-1dc97ae5ed94
# ╠═dad45f0e-08d5-4b91-b276-048611d9b0e0
# ╠═122504c4-c063-4727-8b5f-970eb21efd3c
# ╠═946e8640-eb34-4998-9dd9-c8170a6212f2
# ╠═8232b798-732a-42c0-9d9b-99c62e5c0895
# ╠═845a1605-be2d-4ac2-b287-338695aae2b0
# ╠═b91ff490-21d1-4f39-bf57-4e11e7c62eec
# ╠═b81c4d5a-06ff-4fb4-a159-b0b0ad5b4429
# ╠═cfc72b42-d79b-4802-8e38-7eaed723ac8d
# ╠═28bf3161-80a8-4e9b-b8c3-6b5d41c30b0f
# ╠═deb4fe13-f0ff-4696-a22a-711db6c503a0
# ╠═e705f186-aa45-4e0d-ba3d-1a972da3b6c3
# ╠═c629c3f7-6207-4f9e-a60c-97c53b91953c
# ╠═ea98a1a6-77e3-41b1-a22b-06b1d518b082
# ╠═f6423aa8-72d9-4a3c-977b-0e7decef5af6
# ╠═b396f06a-f50f-48f0-a5db-6ce584f3f354
# ╠═5ff73eaa-f7fb-42c3-8346-6f1b36f4bcd4
# ╠═f14e05b5-1f4b-45ee-9286-1ceff7e005f3
# ╠═a7491586-d529-4ce3-b8a2-276c5dfd6b39
# ╠═cb692706-56de-4d92-8853-e6d30ea9b918
# ╠═149b5bc6-15dd-4a67-a047-95e2fe4e5110
# ╠═5b933fe0-e7d9-4031-8176-d3e3f2a242e4
# ╠═bd275886-d649-4bda-835f-49ba73e07e0a
# ╠═856f4dfb-668f-4361-a7b1-c33fca5549c6
# ╠═90ef2c71-037a-409f-ae2f-36d2e52fb338
# ╟─e4656a24-afc2-4543-acec-ee6f602aaa17
# ╠═51b11ffd-74cd-4e15-ac82-43a0b8eea785
# ╠═a0bcc8bc-1045-41aa-9b51-374ff3206f52
# ╠═fb0e9c58-17a5-48f4-95d9-eccd161fcfe0
# ╠═2c0698cf-76ed-475b-b4ff-472c1cea0f0c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
